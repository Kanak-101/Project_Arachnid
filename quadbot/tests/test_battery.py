import pytest
from quadbot.battery import voltage_to_percent_2s, MockBatteryReader, make_battery_reader


def test_voltage_to_percent_2s_limits():
    assert voltage_to_percent_2s(8.40) == 100.0
    assert voltage_to_percent_2s(8.50) == 100.0
    assert voltage_to_percent_2s(6.60) == 0.0
    assert voltage_to_percent_2s(6.00) == 0.0


def test_voltage_to_percent_2s_intermediate():
    p_78 = voltage_to_percent_2s(7.80)
    assert p_78 == 70.0

    p_76 = voltage_to_percent_2s(7.60)
    assert p_76 == 50.0

    # Monotonicity test
    voltages = [6.7, 7.0, 7.2, 7.4, 7.7, 8.0, 8.3]
    pcts = [voltage_to_percent_2s(v) for v in voltages]
    for i in range(len(pcts) - 1):
        assert pcts[i] < pcts[i + 1]


def test_mock_battery_reader():
    reader = MockBatteryReader(initial_voltage=8.10)
    state = reader.read()
    assert state["present"] is True
    assert state["cells"] == 2
    assert state["state"] == "ok"
    assert 70.0 <= state["percent"] <= 90.0
    assert state["voltage"] == 8.10


def test_make_battery_reader_factory():
    cfg = {
        "battery": {
            "enabled": True,
            "driver": "mock",
            "divider_ratio": 5.0,
        }
    }
    reader = make_battery_reader(cfg)
    assert reader is not None
    st = reader.read()
    assert st["cells"] == 2
