import numpy as np

from quadbot.avoid import AvoidParams, apply

P = AvoidParams()


def scan_with(**arcs):
    s = np.full(360, 3000.0)
    for (a, b), d in arcs.items():
        pass
    return s


def blocked_scan(center, half, dist):
    s = np.full(360, 3000.0)
    for a in range(center - half, center + half + 1):
        s[a % 360] = dist
    return s


def test_clear_path_passes_command_through():
    cmd, info = apply(np.full(360, 3000.0), 0.1, (1.0, 0.0, 0.0), P)
    assert cmd == (1.0, 0.0, 0.0) and info["state"] == "clear"


def test_obstacle_inside_stop_distance_blocks_forward():
    cmd, info = apply(blocked_scan(0, 20, 250), 0.1, (1.0, 0.0, 0.0), P)
    assert cmd[0] == 0.0 and info["state"] == "blocked"


def test_slowdown_is_proportional():
    _, info = apply(blocked_scan(0, 20, 625), 0.1, (1.0, 0.0, 0.0), P)
    assert 0.4 < info["scale"] < 0.6


def test_steers_toward_the_open_side():
    s = blocked_scan(0, 20, 300)
    for a in range(20, 91):            # left side has a wall, right side is open
        s[a] = 500
    cmd, _ = apply(s, 0.1, (1.0, 0.0, 0.0), P)
    assert cmd[2] < 0                   # turn right (clockwise)
    s2 = blocked_scan(0, 20, 300)
    for a in range(270, 341):
        s2[a] = 500
    cmd2, _ = apply(s2, 0.1, (1.0, 0.0, 0.0), P)
    assert cmd2[2] > 0


def test_obstacle_behind_does_not_stop_forward_motion():
    cmd, info = apply(blocked_scan(180, 30, 200), 0.1, (1.0, 0.0, 0.0), P)
    assert cmd[0] == 1.0 and info["state"] == "clear"


def test_backing_up_checks_the_rear():
    cmd, info = apply(blocked_scan(180, 30, 200), 0.1, (-1.0, 0.0, 0.0), P)
    assert abs(cmd[0]) < 1e-9 and info["state"] == "blocked"


def test_stale_scan_stops_translation_but_not_rotation():
    cmd, info = apply(np.full(360, 3000.0), 5.0, (1.0, 0.5, 0.3), P)
    assert cmd == (0.0, 0.0, 0.3) and info["state"] == "lidar_lost"


def test_own_body_returns_are_ignored():
    s = np.full(360, 3000.0)
    s[0:5] = 60                          # closer than min_range_mm: the robot's own hardware
    s[355:] = 60
    _, info = apply(s, 0.1, (1.0, 0.0, 0.0), P)
    assert info["state"] == "clear"


def test_disabled_passes_through():
    p = AvoidParams(enabled=False)
    cmd, info = apply(blocked_scan(0, 20, 100), 5.0, (1.0, 0.0, 0.0), p)
    assert cmd == (1.0, 0.0, 0.0) and info["state"] == "off"
