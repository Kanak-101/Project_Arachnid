import time
from pathlib import Path

import numpy as np

from quadbot import config
from quadbot.hal import MockDriver
from quadbot.robot import Robot

CFG_PATH = Path(__file__).resolve().parent.parent / "config" / "robot.yaml"


class FakeClock:
    def __init__(self):
        self.t = 100.0

    def __call__(self):
        return self.t


class StubLidar:
    def __init__(self, dist=3000.0, age=0.0):
        self.scan, self.age, self.status = np.full(360, dist, dtype=np.float32), age, "stub"

    def snapshot(self):
        return self.scan.copy(), self.age


def make(tmp_path=None, lidar=None):
    cfg = config.load(CFG_PATH)
    path = CFG_PATH
    if tmp_path is not None:
        path = tmp_path / "robot.yaml"
        config.save(cfg, path)
    d = MockDriver()
    r = Robot(cfg, path, d, lidar or StubLidar(), clock=FakeClock())
    return r, d


def run(r, seconds, dt=0.02, keep_alive=None):
    for _ in range(int(seconds / dt)):
        r.clock.t += dt
        if keep_alive:
            r.handle(keep_alive)
        r.tick(dt)


def test_nothing_is_written_while_disarmed():
    r, d = make()
    r.enable_servo("FL_coxa", True)
    r.tick(0.02)
    assert d.pulses == {} and not r.enabled


def test_enable_writes_centre_pulse_and_jogs_are_clamped():
    r, d = make()
    r.arm(True)
    r.enable_servo("FL_coxa", True)
    r.tick(0.02)
    assert d.pulses[0] == 1500
    r.handle({"t": "servo_us", "id": "FL_coxa", "us": 99999})
    r.tick(0.02)
    assert d.pulses[0] < 1600                     # ramps toward the target instead of jumping
    run(r, 2.0)
    assert d.pulses[0] == 2500                    # capped at pulse_abs_max


def test_only_enabled_servos_get_pulses():
    r, d = make()
    r.arm(True)
    s = r.servos["RR_tibia"]
    r.enable_servo("RR_tibia", True)
    r.tick(0.02)
    assert (s.board, s.channel) in d.pulses


def test_estop_releases_everything_and_latches():
    r, d = make()
    r.arm(True)
    r.enable_servo("all", True)
    r.tick(0.02)
    assert len([k for k in d.pulses if isinstance(k, tuple)]) == 12
    r.handle({"t": "estop"})
    assert d.pulses == {} and r.estop and not r.armed
    r.arm(True)
    assert not r.armed                            # cannot re-arm until reset
    r.handle({"t": "reset_estop"})
    r.arm(True)
    assert r.armed


def test_disarm_releases_everything():
    r, d = make()
    r.arm(True)
    r.enable_servo("all", True)
    r.tick(0.02)
    r.arm(False)
    assert d.pulses == {}


def test_calibration_fields():
    r, _ = make()
    r.arm(True)
    r.enable_servo("FL_femur", True)
    r.handle({"t": "servo_us", "id": "FL_femur", "us": 1620})
    run(r, 0.5)
    r.cal("FL_femur", "center")
    s = r.servos["FL_femur"]
    assert s.us_center == 1620
    r.handle({"t": "servo_us", "id": "FL_femur", "us": 1720})
    run(r, 0.5)
    r.cal("FL_femur", "scale_from", 10)           # 100 us for a measured 10 deg
    assert s.us_per_deg == 10.0
    r.cal("FL_femur", "high")
    assert s.us_max == 1720
    r.cal("FL_femur", "invert", True)
    assert s.invert
    r.cal("FL_femur", "channel", 7)
    assert s.channel == 7 and isinstance(s.channel, int)
    r.cal("FL_femur", "board", "right")
    assert s.board == "right" and isinstance(s.board, str)
    r.cal("FL_femur", "board", "left")
    assert r.cal_version > 1


def test_sweep_visits_both_limits_and_finishes():
    r, d = make()
    r.arm(True)
    r.enable_servo("FL_coxa", True)
    r.handle({"t": "servo_sweep", "id": "FL_coxa"})
    seen = []
    for _ in range(int(60 / 0.02)):
        r.clock.t += 0.02
        r.tick(0.02)
        seen.append(d.pulses[0])
        if r.sweep is None:
            break
    assert r.sweep is None
    assert max(seen) == 2500 and min(seen) == 500 and seen[-1] == 1500


def test_switching_to_stand_ramps_at_rated_speed():
    r, d = make()
    r.arm(True)
    r.enable_servo("all", True)
    r.tick(0.02)
    r.set_mode("stand")
    prev = {sid: r.servos[sid].us_to_deg(d.pulses[(s.board, s.channel)]) for sid, s in r.servos.items()}
    worst = 0.0
    for _ in range(200):
        r.tick(0.02)
        for sid, s in r.servos.items():
            deg = s.us_to_deg(d.pulses[(s.board, s.channel)])
            worst = max(worst, abs(deg - prev[sid]) / 0.02 - s.max_speed_dps)
            prev[sid] = deg
    assert worst < 0.5                            # never faster than the rated speed


def test_stale_drive_command_stops_the_robot():
    r, d = make()
    r.arm(True)
    r.enable_servo("all", True)
    r.set_mode("crawl")
    run(r, 1.0, keep_alive={"t": "drive", "vx": 1, "vy": 0, "wz": 0})
    assert max(abs(c) for c in r.gait.cs) > 0.5
    run(r, 2.0)                                   # no more drive messages
    assert max(abs(c) for c in r.gait.cs) < 0.05


def test_drive_values_are_clamped():
    r, _ = make()
    r.handle({"t": "drive", "vx": 9, "vy": -9, "wz": 0.5})
    assert r.cmd == (1.0, -1.0, 0.5)


def test_avoidance_blocks_forward_walking_and_lidar_loss_is_flagged():
    near = StubLidar(dist=250.0)
    r, _ = make(lidar=near)
    r.arm(True)
    r.enable_servo("all", True)
    r.set_mode("crawl")
    run(r, 1.0, keep_alive={"t": "drive", "vx": 1, "vy": 0, "wz": 0})
    assert r.avoid_info["state"] == "blocked"
    assert abs(r.gait.cs[0]) < 0.05
    r.lidar = StubLidar(age=9.0)
    run(r, 0.5, keep_alive={"t": "drive", "vx": 1, "vy": 0, "wz": 0})
    assert r.avoid_info["state"] == "lidar_lost"


def test_auto_derate_slows_the_gait_when_a_servo_is_too_slow():
    r, _ = make()
    r.servos["FL_femur"].max_speed_dps = 10.0     # pretend this servo is very slow
    r.arm(True)
    r.enable_servo("all", True)
    r.set_mode("crawl")
    run(r, 30.0, keep_alive={"t": "drive", "vx": 1, "vy": 0, "wz": 0})
    assert r.derate.scale < 0.9
    assert r.limiter.sat["FL_femur"] > 0.0


def test_legtest_moves_only_the_requested_leg_target():
    r, d = make()
    r.arm(True)
    r.enable_servo("all", True)
    r.set_mode("legtest")
    before = dict(r.leg_targets)
    r.handle({"t": "leg", "leg": "FL", "x": 130, "y": 20, "z": -80})
    assert r.leg_targets["FL"] == (130.0, 20.0, -80.0)
    assert r.leg_targets["FR"] == before["FR"]
    run(r, 3.0)
    assert r.reach_ok["FL"]


def test_save_config_round_trips(tmp_path):
    r, _ = make(tmp_path)
    r.cal("FL_coxa", "invert", True)
    r.handle({"t": "save"})
    reloaded = config.load(tmp_path / "robot.yaml")
    fl = next(s for s in reloaded["servos"] if s["id"] == "FL_coxa")
    assert fl["invert"] is True
    assert (tmp_path / "robot.yaml.bak").exists()


def test_control_tick_is_cheap():
    r, _ = make()
    r.arm(True)
    r.enable_servo("all", True)
    r.set_mode("trot")
    t0 = time.perf_counter()
    for _ in range(500):
        r.handle({"t": "drive", "vx": 1, "vy": 0, "wz": 0.3})
        r.tick(0.02)
    per_tick_ms = (time.perf_counter() - t0) / 500 * 1000
    assert per_tick_ms < 5.0


def test_jog_speed_never_exceeds_the_configured_ramp():
    r, d = make()
    r.arm(True)
    s = r.servos["FR_femur"]
    r.enable_servo("FR_femur", True)
    r.tick(0.02)
    prev = d.pulses[(s.board, s.channel)]
    r.handle({"t": "servo_us", "id": "FR_femur", "us": 500})
    worst = 0.0
    for _ in range(200):
        r.tick(0.02)
        worst = max(worst, abs(d.pulses[(s.board, s.channel)] - prev) / 0.02)
        prev = d.pulses[(s.board, s.channel)]
    assert worst <= r.jog_rate + 1e-6 and prev == 500
