from pathlib import Path
import pytest

from quadbot import config
from quadbot.kinematics import LegKinematics
from quadbot.poses import BodyPoseEngine, PoseActionEngine
from quadbot.servos import ServoCal

CFG_PATH = Path(__file__).resolve().parent.parent / "config" / "robot.yaml"


@pytest.fixture
def robot_setup():
    cfg = config.load(CFG_PATH)
    kin = LegKinematics(**cfg["geometry"])
    servos = {s["id"]: ServoCal.from_dict(s) for s in cfg["servos"]}
    stance_reach = float(cfg["gait"].get("stance_reach", 123.0))
    height_stand = float(cfg["gait"].get("height_stand", 87.0))
    th1, a, b, ok = kin.ik_deg(stance_reach, 0.0, -height_stand)
    assert ok
    neutral_deg = {}
    for leg in cfg["legs"]:
        neutral_deg[f"{leg}_coxa"] = th1
        neutral_deg[f"{leg}_femur"] = a
        neutral_deg[f"{leg}_tibia"] = b
    engine = PoseActionEngine(cfg, kin, neutral_deg, servos)
    return cfg, kin, neutral_deg, servos, engine


def test_body_pose_engine_neutral():
    cfg = config.load(CFG_PATH)
    reach = float(cfg["gait"].get("stance_reach", 123.0))
    height = float(cfg["gait"].get("height_stand", 87.0))
    body = BodyPoseEngine(cfg["legs"], reach, height)

    feet = body.compute_feet()
    assert len(feet) == 4
    for leg, (x, y, z) in feet.items():
        assert abs(x - reach) < 1e-4
        assert abs(y) < 1e-4
        assert abs(z - (-height)) < 1e-4


def test_body_pose_engine_translation_and_reachability(robot_setup):
    _, kin, _, _, engine = robot_setup
    body = engine.body_engine

    # Test small shifts in all directions
    for dx in (-15, 0, 15):
        for dy in (-15, 0, 15):
            for dz in (-10, 0, 10):
                feet = body.compute_feet(dx=dx, dy=dy, dz=dz)
                for leg, (x, y, z) in feet.items():
                    _, _, _, ok = kin.ik_deg(x, y, z)
                    assert ok, f"Unreachable foot for leg {leg} at dx={dx}, dy={dy}, dz={dz}"


def test_body_pose_engine_rotation_and_reachability(robot_setup):
    _, kin, _, _, engine = robot_setup
    body = engine.body_engine

    for roll in (-5.0, 0.0, 5.0):
        for pitch in (-6.0, 0.0, 6.0):
            for yaw in (-6.0, 0.0, 6.0):
                feet = body.compute_feet(roll_deg=roll, pitch_deg=pitch, yaw_deg=yaw)
                for leg, (x, y, z) in feet.items():
                    _, _, _, ok = kin.ik_deg(x, y, z)
                    assert ok, f"Unreachable foot for leg {leg} at roll={roll}, pitch={pitch}, yaw={yaw}"


def test_dance_trajectory_and_figures(robot_setup):
    _, _, _, _, engine = robot_setup

    # Test all 4 choreographed figures across 12.0s
    times_and_expected_figures = [
        (1.5, "Front-Back Groove"),
        (4.5, "Side-to-Side Sway"),
        (7.0, "Diagonal Sway"),
        (8.5, "Reverse Diagonal"),
        (10.5, "360° Salsa Orbit"),
    ]

    for t, expected_fig in times_and_expected_figures:
        targets, info = engine.dance_targets(t)
        assert info["figure"] == expected_fig
        assert len(targets) == 12
        for sid, val in targets.items():
            assert isinstance(val, (int, float))
            assert not isinstance(val, bool)


def test_wave_trajectory_and_limits(robot_setup):
    _, _, _, _, engine = robot_setup

    # During wave peak (t=2.0s), FL tibia and femur should be strongly lifted
    targets, done = engine.wave_targets(2.0, duration=4.2, wave_leg="FL")
    assert not done
    assert targets["FL_femur"] > 35.0   # Femur elevated
    assert targets["FL_tibia"] > 50.0   # Tibia lifted high off ground to calibrated limit
    assert abs(targets["FL_coxa"]) <= 30.0

    # At t >= 4.2s, wave finishes
    _, done_end = engine.wave_targets(4.3, duration=4.2, wave_leg="FL")
    assert done_end


def test_pushup_action(robot_setup):
    _, _, _, _, engine = robot_setup

    # Mid-dip of rep 1
    targets, done = engine.pushup_targets(0.65, reps=3, rep_time=1.3)
    assert not done
    assert len(targets) == 12

    # After 3 reps (3.9s)
    _, done_end = engine.pushup_targets(4.0, reps=3, rep_time=1.3)
    assert done_end


def test_bow_action(robot_setup):
    _, _, _, _, engine = robot_setup

    targets, done = engine.bow_targets(1.5, hold_sec=3.2)
    assert not done
    # Front legs lowered (more negative z offset), rear elevated
    assert len(targets) == 12

    _, done_end = engine.bow_targets(3.5, hold_sec=3.2)
    assert done_end


def test_wiggle_action(robot_setup):
    _, _, _, _, engine = robot_setup

    targets, done = engine.wiggle_targets(1.5, duration=3.0)
    assert not done
    # Front legs damped relative to rear
    assert abs(targets["FL_coxa"]) < abs(targets["RL_coxa"]) + 1e-4

    _, done_end = engine.wiggle_targets(3.2, duration=3.0)
    assert done_end


def test_stretch_action(robot_setup):
    _, _, _, _, engine = robot_setup

    targets1, _ = engine.stretch_targets(1.2, duration=5.0)  # Downward dog
    targets2, _ = engine.stretch_targets(3.8, duration=5.0)  # Upward arch
    assert len(targets1) == 12
    assert len(targets2) == 12

    _, done_end = engine.stretch_targets(5.1, duration=5.0)
    assert done_end


def test_peek_action(robot_setup):
    _, _, _, _, engine = robot_setup

    targets, done = engine.peek_targets(2.0, duration=5.0)
    assert not done
    assert len(targets) == 12

    _, done_end = engine.peek_targets(5.2, duration=5.0)
    assert done_end


def test_shake_action(robot_setup):
    _, _, _, _, engine = robot_setup

    targets, done = engine.shake_targets(0.9, duration=1.8)
    assert not done
    assert len(targets) == 12

    _, done_end = engine.shake_targets(1.9, duration=1.8)
    assert done_end
