from quadbot.hal import PCA9685Driver, MockDriver


class FakeBus:
    def __init__(self):
        self.byte, self.block = [], []

    def write_byte_data(self, addr, reg, val):
        self.byte.append((addr, reg, val))

    def write_i2c_block_data(self, addr, reg, data):
        self.block.append((addr, reg, list(data)))


def test_pca9685_init_sets_50hz_prescale():
    bus = FakeBus()
    PCA9685Driver(bus_obj=bus)
    assert (0x40, 0xFE, 121) in bus.byte          # 25 MHz / (4096 * 50) - 1


def test_pulse_to_ticks():
    bus = FakeBus()
    d = PCA9685Driver(bus_obj=bus)
    bus.block.clear()
    d.set_pulse(3, 1500)                           # 1500 us of a 20 ms frame = 307 ticks
    addr, reg, data = bus.block[-1]
    assert reg == 0x06 + 4 * 3 and data[2] + (data[3] << 8) == 307


def test_release_sets_full_off_bit():
    bus = FakeBus()
    d = PCA9685Driver(bus_obj=bus)
    bus.block.clear()
    d.release(5)
    assert bus.block[-1][2] == [0, 0, 0, 0x10]


def test_mock_driver_tracks_and_releases():
    m = MockDriver()
    m.set_pulse(2, 1500)
    assert m.pulses[2] == 1500
    m.release_all()
    assert m.pulses == {}


def test_pca9685_dual_boards_init_and_routing():
    bus = FakeBus()
    boards = {
        "left": {"bus": 1, "address": 0x40},
        "right": {"bus": 1, "address": 0x41},
    }
    d = PCA9685Driver(boards=boards, bus_obj=bus)
    # Both boards should be initialized with 50 Hz prescaler (121)
    assert (0x40, 0xFE, 121) in bus.byte
    assert (0x41, 0xFE, 121) in bus.byte

    bus.block.clear()
    d.set_pulse(0, 1500, board="left")
    assert bus.block[-1][0] == 0x40 and bus.block[-1][1] == 0x06

    d.set_pulse(0, 1600, board="right")
    assert bus.block[-1][0] == 0x41 and bus.block[-1][1] == 0x06

    d.release(2, board="left")
    assert bus.block[-1][0] == 0x40 and bus.block[-1][1] == 0x06 + 4 * 2
    assert bus.block[-1][2] == [0, 0, 0, 0x10]

    d.release(3, board="right")
    assert bus.block[-1][0] == 0x41 and bus.block[-1][1] == 0x06 + 4 * 3
    assert bus.block[-1][2] == [0, 0, 0, 0x10]

    bus.block.clear()
    d.release_all()
    addrs = [entry[0] for entry in bus.block]
    assert addrs.count(0x40) == 16
    assert addrs.count(0x41) == 16


def test_mock_driver_multi_board():
    m = MockDriver()
    m.set_pulse(0, 1500, board="left")
    m.set_pulse(0, 1600, board="right")
    assert m.pulses[("left", 0)] == 1500
    assert m.pulses[("right", 0)] == 1600

    m.release(0, board="left")
    assert ("left", 0) not in m.pulses
    assert m.pulses[("right", 0)] == 1600
    assert m.pulses[0] == 1600

    m.release(0, board="right")
    assert ("right", 0) not in m.pulses
    assert 0 not in m.pulses

