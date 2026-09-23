"""Hardware abstraction for the servo output.

Everything above this file talks in microseconds of pulse width per channel, so the
same code runs against a mock (laptop, tests) or a PCA9685 board (Raspberry Pi).
"""
import threading
import time

_I2C_LOCKS = {}


def get_i2c_lock(bus_num=1):
    """Returns a shared reentrant lock for a given I2C bus number."""
    if bus_num not in _I2C_LOCKS:
        _I2C_LOCKS[bus_num] = threading.RLock()
    return _I2C_LOCKS[bus_num]


class ServoDriver:
    def set_pulse(self, channel: int, us: float, board: str = "default"):
        raise NotImplementedError

    def release(self, channel: int, board: str = "default"):
        """Stop sending pulses on this channel (servo goes limp)."""
        raise NotImplementedError

    def release_all(self):
        for ch in range(16):
            self.release(ch)

    def close(self):
        self.release_all()


class MockDriver(ServoDriver):
    def __init__(self):
        self.pulses = {}

    def set_pulse(self, channel: int, us: float, board: str = "default"):
        self.pulses[(board, channel)] = us
        self.pulses[channel] = us

    def release(self, channel: int, board: str = "default"):
        self.pulses.pop((board, channel), None)
        if not any(isinstance(k, tuple) and k[1] == channel for k in self.pulses):
            self.pulses.pop(channel, None)

    def release_all(self):
        self.pulses.clear()


class PCA9685Board:
    MODE1, MODE2, PRESCALE, LED0 = 0x00, 0x01, 0xFE, 0x06
    ALL_LED_ON_L, ALL_LED_OFF_H = 0xFA, 0xFD

    def __init__(self, bus_obj, address=0x40, freq_hz=50, osc_hz=25_000_000, stagger=True, bus_num=1):
        self.bus, self.addr, self.freq, self.stagger = bus_obj, address, freq_hz, stagger
        self.lock = get_i2c_lock(bus_num)
        self._last_pulse = {}
        prescale = int(round(osc_hz / (4096 * freq_hz))) - 1
        self._write_byte(self.MODE1, 0x00)      # wake
        time.sleep(0.005)
        self._write_byte(self.MODE1, 0x10)      # sleep so we can set the prescaler
        time.sleep(0.005)
        self._write_byte(self.PRESCALE, prescale)
        self._write_byte(self.MODE1, 0x20)      # wake, auto-increment
        time.sleep(0.005)
        self._write_byte(self.MODE2, 0x04)      # totem-pole / push-pull output (required for servos)
        self._write_byte(self.ALL_LED_OFF_H, 0x00) # clear global ALL_LED_OFF bit (unlatches chip)
        self._write_byte(0xFB, 0x00)            # clear global ALL_LED_ON bit
        self.release_all()

    def _write_byte(self, reg, val):
        with self.lock:
            for attempt in range(3):
                try:
                    self.bus.write_byte_data(self.addr, reg, val)
                    return
                except (OSError, IOError):
                    if attempt == 2:
                        raise
                    time.sleep(0.002)

    def _write_block(self, reg, data):
        with self.lock:
            for attempt in range(3):
                try:
                    self.bus.write_i2c_block_data(self.addr, reg, data)
                    return
                except (OSError, IOError):
                    if attempt == 2:
                        raise
                    time.sleep(0.002)

    def set_pulse(self, channel, us):
        prev = self._last_pulse.get(channel)
        if prev is not None and abs(prev - us) < 0.8:
            return
        self._last_pulse[channel] = us
        ticks = int(round(us * 4096 * self.freq / 1e6))
        ticks = max(0, min(4095, ticks))
        if self.stagger:
            on_tick = (channel * 256) % 4096
            off_tick = (on_tick + ticks) % 4096
        else:
            on_tick, off_tick = 0, ticks
        self._write_block(
            self.LED0 + 4 * channel,
            [on_tick & 0xFF, (on_tick >> 8) & 0x0F, off_tick & 0xFF, (off_tick >> 8) & 0x0F]
        )

    def release(self, channel):
        self._last_pulse.pop(channel, None)
        # bit 4 of LEDn_OFF_H = "full off": the output stays low, so the servo is unpowered
        self._write_block(self.LED0 + 4 * channel, [0, 0, 0, 0x10])

    def release_all(self):
        self._last_pulse.clear()
        for ch in range(16):
            self.release(ch)


class PCA9685Driver(ServoDriver):
    MODE1, PRESCALE, LED0 = 0x00, 0xFE, 0x06

    def __init__(self, bus=1, address=0x40, freq_hz=50, osc_hz=25_000_000, bus_obj=None, boards=None):
        self._bus_cache = {}
        self.boards = {}

        if boards is None:
            boards = {
                "default": {
                    "bus": bus,
                    "address": address,
                    "freq_hz": freq_hz,
                    "osc_hz": osc_hz,
                }
            }

        for name, b_cfg in boards.items():
            b_bus = b_cfg.get("bus", bus)
            b_addr = b_cfg.get("address", address)
            b_freq = b_cfg.get("freq_hz", freq_hz)
            b_osc = b_cfg.get("osc_hz", osc_hz)
            b_stagger = b_cfg.get("stagger", True)

            if bus_obj is not None:
                cur_bus = bus_obj.get(name, bus_obj) if isinstance(bus_obj, dict) else bus_obj
            else:
                if b_bus not in self._bus_cache:
                    from smbus2 import SMBus  # imported lazily: only needed on the Pi
                    self._bus_cache[b_bus] = SMBus(b_bus)
                cur_bus = self._bus_cache[b_bus]

            self.boards[name] = PCA9685Board(cur_bus, b_addr, b_freq, b_osc, stagger=b_stagger, bus_num=b_bus)

    def _resolve_board(self, board):
        if board in self.boards:
            return self.boards[board]
        if len(self.boards) == 1:
            return next(iter(self.boards.values()))
        if "default" in self.boards:
            return self.boards["default"]
        raise KeyError(f"Unknown board '{board}'. Configured boards: {list(self.boards.keys())}")

    def set_pulse(self, channel, us, board="default"):
        self._resolve_board(board).set_pulse(channel, us)

    def release(self, channel, board="default"):
        self._resolve_board(board).release(channel)

    def release_all(self):
        for b in self.boards.values():
            b.release_all()

    def close(self):
        self.release_all()
        for bus in self._bus_cache.values():
            try:
                bus.close()
            except Exception:
                pass
        self._bus_cache.clear()


def make_driver(cfg):
    if cfg.get("driver", "mock") == "pca9685":
        p = cfg.get("pca9685", {})
        stagger = p.get("stagger", False)
        if "boards" in p:
            for b in p["boards"].values():
                if "stagger" not in b:
                    b["stagger"] = stagger
            return PCA9685Driver(boards=p["boards"])
        return PCA9685Driver(p.get("bus", 1), p.get("address", 0x40),
                             p.get("freq_hz", 50), p.get("osc_hz", 25_000_000))
    return MockDriver()
