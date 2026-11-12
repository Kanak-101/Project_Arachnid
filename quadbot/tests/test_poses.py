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
        (1.5, "Popping Beat Bounce"),
        (4.5, "Shoulder Shimmy Shake"),
        (7.0, "Diagonal Pop Lock"),
        (8.5, "Reverse Diag Pop"),
        (10.5, "Breakdance Pop Orbit"),
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

    # During wave peak (t=2.0s), FL femur is elevated and tibia is folded UP in the air (positive angle for invert:false)
    targets, done = engine.wave_targets(2.0, duration=4.2, wave_leg="FL")
    assert not done
    assert targets["FL_femur"] > 70.0   # Femur elevated (~83 deg)
    assert targets["FL_tibia"] > 50.0   # Tibia folded UP into the air (~61-67 deg)
    assert abs(targets["FL_coxa"]) <= 30.0

    # Supporting leg coxas remain at 1500 us (0.0 deg)
    assert targets["FR_coxa"] == 0.0
    assert targets["RL_coxa"] == 0.0
    assert targets["RR_coxa"] == 0.0

    # At t >= 4.2s, wave finishes and returns to stand
    targets_end, done_end = engine.wave_targets(4.3, duration=4.2, wave_leg="FL")
    assert done_end
    for v in targets_end.values():
        assert abs(v) < 1e-4


def test_wave_calibrated_microsecond_outputs(robot_setup):
    _, _, _, servos, engine = robot_setup

    # Test Preset 1 during stable balance hold (t=1.5s, wave_osc is near 0)
    targets1, _ = engine.wave_targets(1.5, duration=4.2, wave_leg="FL", pose_set=1)
    assert abs(servos["FR_femur"].deg_to_us(targets1["FR_femur"]) - 2190.0) < 1.0
    assert abs(servos["FR_tibia"].deg_to_us(targets1["FR_tibia"]) - 1460.0) < 1.0
    assert abs(servos["RL_femur"].deg_to_us(targets1["RL_femur"]) - 1832.0) < 1.0
    assert abs(servos["RL_tibia"].deg_to_us(targets1["RL_tibia"]) - 1571.0) < 1.0
    assert abs(servos["RR_femur"].deg_to_us(targets1["RR_femur"]) - 1429.0) < 1.0
    assert abs(servos["RR_tibia"].deg_to_us(targets1["RR_tibia"]) - 1143.0) < 1.0
    assert abs(servos["FL_femur"].deg_to_us(targets1["FL_femur"]) - 1269.0) < 1.0
    assert abs(servos["FR_coxa"].deg_to_us(targets1["FR_coxa"]) - 1500.0) < 1.0
    assert abs(servos["RL_coxa"].deg_to_us(targets1["RL_coxa"]) - 1500.0) < 1.0
    assert abs(servos["RR_coxa"].deg_to_us(targets1["RR_coxa"]) - 1500.0) < 1.0

    # Test Preset 2
    targets2, _ = engine.wave_targets(1.5, duration=4.2, wave_leg="FL", pose_set=2)
    assert abs(servos["FR_femur"].deg_to_us(targets2["FR_femur"]) - 2300.0) < 1.0
    assert abs(servos["FR_tibia"].deg_to_us(targets2["FR_tibia"]) - 1625.0) < 1.0
    assert abs(servos["RL_femur"].deg_to_us(targets2["RL_femur"]) - 2100.0) < 1.0
    assert abs(servos["RL_tibia"].deg_to_us(targets2["RL_tibia"]) - 1672.0) < 1.0
    assert abs(servos["RR_femur"].deg_to_us(targets2["RR_femur"]) - 2000.0) < 1.0
    assert abs(servos["RR_tibia"].deg_to_us(targets2["RR_tibia"]) - 2010.0) < 1.0
    assert abs(servos["FL_femur"].deg_to_us(targets2["FL_femur"]) - 1270.0) < 1.0


def test_pushup_action(robot_setup):
    _, _, _, _, engine = robot_setup

    # Mid-dip of rep 1
    targets, done = engine.pushup_targets(0.65, reps=3, rep_time=1.3)
    assert not done
    assert len(targets) == 12

    # After 3 reps (3.9s)
    _, done_end = engine.pushup_targets(4.0, reps=3, rep_time=1.3)
    assert done_end


def test_crab_action(robot_setup):
    _, _, _, _, engine = robot_setup

    targets, done = engine.crab_targets(0.9, duration=6.0)
    assert not done
    assert len(targets) == 12

    _, done_end = engine.crab_targets(6.2, duration=6.0)
    assert done_end


def test_bow_action(robot_setup):
    _, _, _, _, engine = robot_setup

    targets, done = engine.bow_targets(1.5, hold_sec=3.2)
    assert not done
    assert len(targets) == 12

    _, done_end = engine.bow_targets(3.5, hold_sec=3.2)
    assert done_end


def test_wiggle_action(robot_setup):
    _, _, _, _, engine = robot_setup

    targets, done = engine.wiggle_targets(1.5, duration=3.0)
    assert not done
    # Front legs damped relative to rear, and rear coxa boosted
    assert abs(targets["FL_coxa"]) < abs(targets["RL_coxa"])
    assert abs(targets["RL_coxa"]) > 10.0

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
