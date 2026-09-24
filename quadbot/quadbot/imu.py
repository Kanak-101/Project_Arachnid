"""Optional MPU-6050 attitude reader with a small complementary filter."""
import math
import threading
import time


class MPU6050:
    PWR_MGMT_1 = 0x6B
    ACCEL_XOUT_H = 0x3B
    GYRO_XOUT_H = 0x43

    def __init__(self, bus_num=1, address=0x68, rate_hz=100, alpha=0.98):
        self.bus_num = bus_num
        self.address = address
        self.rate_hz = rate_hz
        self.alpha = alpha
        self.roll = 0.0
        self.pitch = 0.0
        self.ready = False
        self.error = ""
        self._stop = threading.Event()
        self._thread = None
        self._lock = threading.Lock()
        self._bus = None

    @staticmethod
    def _signed(high, low):
        value = (high << 8) | low
        return value - 65536 if value & 0x8000 else value

    def start(self):
        try:
            from smbus2 import SMBus
            self._bus = SMBus(self.bus_num)
            self._bus.write_byte_data(self.address, self.PWR_MGMT_1, 0)
            self.ready = True
            self._thread = threading.Thread(target=self._run, daemon=True)
            self._thread.start()
        except Exception as exc:
            self.error = str(exc)
            self.ready = False

    def _read(self):
        data = self._bus.read_i2c_block_data(self.address, self.ACCEL_XOUT_H, 14)
        ax = self._signed(data[0], data[1]) / 16384.0
        ay = self._signed(data[2], data[3]) / 16384.0
        az = self._signed(data[4], data[5]) / 16384.0
        gx = self._signed(data[8], data[9]) / 131.0
        gy = self._signed(data[10], data[11]) / 131.0
        roll_acc = math.degrees(math.atan2(ay, az))
        pitch_acc = math.degrees(math.atan2(-ax, math.hypot(ay, az)))
        return roll_acc, pitch_acc, gx, gy

    def _run(self):
        last = time.monotonic()
        while not self._stop.wait(1.0 / self.rate_hz):
            try:
                roll_acc, pitch_acc, gx, gy = self._read()
                now = time.monotonic()
                dt = min(max(now - last, 0.001), 0.1)
                last = now
                with self._lock:
                    self.roll = self.alpha * (self.roll + gx * dt) + (1 - self.alpha) * roll_acc
                    self.pitch = self.alpha * (self.pitch + gy * dt) + (1 - self.alpha) * pitch_acc
            except Exception as exc:
                self.error = str(exc)
                self.ready = False

    def attitude(self):
        with self._lock:
            return self.roll, self.pitch

    def close(self):
        self._stop.set()
        if self._thread:
            self._thread.join(timeout=0.2)
        if self._bus:
            self._bus.close()