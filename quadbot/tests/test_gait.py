import math
from pathlib import Path

from quadbot import config
from quadbot.gait import GaitEngine
from quadbot.kinematics import LegKinematics

CFG = config.load(Path(__file__).resolve().parent.parent / "config" / "robot.yaml")
K = LegKinematics(**CFG["geometry"])
DT = 0.02


def run(mode, cmd, seconds=8.0, warm=3.0):
    g = GaitEngine(CFG)
    frames = []
    for i in range(int(seconds / DT)):
        feet = g.update(DT, mode, cmd)
        if i * DT >= warm:
            frames.append((feet, list(g.swing)))
    return g, frames


def test_all_foot_targets_are_reachable_when_walking_and_turning():
    for mode in ("crawl", "trot"):
        for cmd in [(1, 0, 0), (-1, 0, 0), (0, 1, 0), (0, 0, 1), (0.7, 0.7, 0.5)]:
            _, frames = run(mode, cmd)
            for feet, _ in frames:
                for leg, (x, y, z) in feet.items():
                    assert K.ik(x, y, z)[3], (mode, cmd, leg, x, y, z)


def test_crawl_never_lifts_more_than_one_leg():
    _, frames = run("crawl", (1, 0, 0))
    assert max(len(s) for _, s in frames) == 1
    assert any(len(s) == 1 for _, s in frames)


def test_crawl_swing_has_clearance_at_low_command():
    _, frames = run("crawl", (0.1, 0, 0))
    lifts = [feet[leg][2] - (-CFG["gait"]["height_stand"]) for feet, swing in frames for leg in swing]
    assert lifts and max(lifts) >= CFG["gait"]["step_height"] * 0.9


def test_per_leg_lift_trim_increases_left_leg_clearance():
    cfg = {**CFG, "gait": {**CFG["gait"], "lift_scale_by_leg": {"FL": 1.4, "FR": 1.0, "RL": 1.4, "RR": 1.0}}}
    g = GaitEngine(cfg)
    g.cs = [1.0, 0.0, 0.0]
    left_max = right_max = 0.0
    for i in range(200):
        g.phase = i / 200
        feet = g.update(0.0, "crawl", (1, 0, 0))
        for leg in ("FL", "RL"):
            left_max = max(left_max, feet[leg][2] + g.height)
        for leg in ("FR", "RR"):
            right_max = max(right_max, feet[leg][2] + g.height)
    assert left_max > right_max


def test_trot_lifts_diagonal_pairs():
    _, frames = run("trot", (1, 0, 0))
    pairs = {tuple(sorted(s)) for _, s in frames if s}
    assert ("FL", "RR") in pairs and ("FR", "RL") in pairs
    assert all(len(s) in (0, 2) for _, s in frames)


def test_stance_feet_slide_backward_when_walking_forward():
    g, frames = run("crawl", (1, 0, 0), seconds=10)
    ys = [f[0]["FL"][1] for f in frames if "FL" not in f[1]]
    diffs = [b - a for a, b in zip(ys, ys[1:]) if abs(b - a) < 5]
    assert sum(1 for d in diffs if d < 0) > 0.9 * len(diffs)


def test_turning_moves_left_and_right_feet_in_opposite_directions():
    _, frames = run("crawl", (0, 0, 1), seconds=10)

    def drift(leg):
        ys = [f[0][leg][1] for f in frames if leg not in f[1]]
        d = [b - a for a, b in zip(ys, ys[1:]) if abs(b - a) < 5]
        return sum(d) / len(d)

    assert drift("FL") > 0 > drift("FR")


def test_idle_stand_holds_still_at_stand_height():
    g = GaitEngine(CFG)
    for _ in range(400):
        feet = g.update(DT, "stand", (1, 0, 0))     # drive is ignored in stand
    for leg, (x, y, z) in feet.items():
        assert abs(z + CFG["gait"]["height_stand"]) < 0.5 and abs(y) < 0.5


def test_rest_is_lower_than_stand():
    g = GaitEngine(CFG)
    for _ in range(400):
        rest = g.update(DT, "rest", (0, 0, 0))
    assert rest["FL"][2] > -CFG["gait"]["height_rest"] - 0.5


def test_feet_settle_when_command_stops():
    g = GaitEngine(CFG)
    for _ in range(300):
        g.update(DT, "crawl", (1, 0, 0))
    for _ in range(300):
        feet = g.update(DT, "crawl", (0, 0, 0))
    for leg, (x, y, z) in feet.items():
        assert abs(z + g.height) < 3.0 and abs(y) < 3.0
