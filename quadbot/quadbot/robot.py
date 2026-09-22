"""The robot controller: one place that owns safety state, modes and the control tick.

Safety rules, in order of importance:
  * Nothing moves until the robot is ARMED, and a servo only gets pulses once you
    enable that individual servo. Disabled servos are released (limp).
  * E-stop and disarm release every channel immediately.
  * No fresh drive command for `command_timeout_s` -> the drive command falls to zero.
  * Pulses are clamped to each servo's calibrated hard limits and speed-limited.
"""
import time
from dataclasses import asdict

from . import avoid as avoidmod
from .config import save as save_cfg
from .gait import GaitEngine, GAITS
from .kinematics import LegKinematics
from .servos import AutoDerate, ServoCal, SlewLimiter

MODES = ("calib", "legtest", "rest", "stand", "crawl", "trot")
CAL_FIELDS = ("channel", "board", "us_per_deg", "max_speed_dps", "deg_min", "deg_max")


class Robot:
    def __init__(self, cfg, cfg_path, driver, lidar, clock=time.monotonic):
        self.clock = clock                  # injectable so tests can fast-forward the watchdog
        self.cfg, self.cfg_path = cfg, cfg_path
        self.driver, self.lidar = driver, lidar
        has_dual = "boards" in cfg.get("pca9685", {})
        for s in cfg.get("servos", []):
            if "board" not in s and has_dual:
                s["board"] = "left" if s.get("leg") in ("FL", "RL") else "right"
        self.servos = {s["id"]: ServoCal.from_dict(s) for s in cfg["servos"]}
        g = cfg["geometry"]
        self.kin = LegKinematics(g["coxa"], g["femur"], g["tibia"])
        self.gait = GaitEngine(cfg)
        self.limiter = SlewLimiter()
        self.derate = AutoDerate()
        self.avoid = avoidmod.AvoidParams(**cfg.get("avoid", {}))
        c = cfg["control"]
        self.timeout = c["command_timeout_s"]
        self.abs_lo, self.abs_hi = c["pulse_abs_min"], c["pulse_abs_max"]
        self.sweep_rate = c.get("sweep_rate_us_s", 300)
        self.jog_rate = c.get("jog_rate_us_s", 1200)     # calibration pulses ramp at this speed, never jump

        self.mode = "calib"
        self.armed = False
        self.estop = False
        self.enabled = set()
        self.manual_us = {sid: s.us_center for sid, s in self.servos.items()}      # pulse actually being sent
        self.manual_target = dict(self.manual_us)                                  # where the dashboard wants it
        self.out_us = {}                    # last pulse written per servo
        self.cmd, self.cmd_t = (0.0, 0.0, 0.0), 0.0
        self.leg_targets = self.gait.nominal(cfg["gait"]["height_stand"])
        self.sweep = None
        self.auto_derate = True
        self.avoid_info = {"state": "off", "front_mm": None, "scale": 1.0}
        self.reach_ok = {leg: True for leg in cfg["legs"]}
        self.cal_version = 1
        self.notice = ""
        self.tick_ms = 0.0
        self._i2c_errors = 0

    # ---------------------------------------------------------------- safety
    def arm(self, on):
        if on and self.estop:
            self.notice = "E-stop is latched: reset it first"
            return
        self.armed = bool(on)
        if not self.armed:
            self._release_all()
        elif self.mode in ("stand", "crawl", "trot") and not self.enabled:
            self.enable_servo("all", True)
            self.notice = f"Armed and enabled all servos in {self.mode} mode"

    def trigger_estop(self):
        self.estop, self.armed, self.sweep = True, False, None
        self.cmd = (0.0, 0.0, 0.0)
        self._release_all()
        self.notice = "E-STOP: all servos released"

    def reset_estop(self):
        self.estop = False
        self.notice = "E-stop reset. Arm and enable servos again"

    def _release_all(self):
        self.enabled.clear()
        self.out_us.clear()
        self.sweep = None
        self.driver.release_all()

    # ---------------------------------------------------------------- per-servo
    def enable_servo(self, sid, on):
        if sid == "all":
            for s in self.servos:
                self.enable_servo(s, on)
            return
        if sid not in self.servos:
            return
        s = self.servos[sid]
        if on:
            if not self.armed:
                self.notice = "Arm the robot before enabling servos"
                return
            cur = self.limiter.cur.get(sid)
            self.manual_us[sid] = s.deg_to_us(cur) if cur is not None else s.us_center
            self.manual_target[sid] = self.manual_us[sid]
            if cur is None:
                self.limiter.reset(sid, 0.0)
            self.enabled.add(sid)
        else:
            self.enabled.discard(sid)
            self.out_us.pop(sid, None)
            self.driver.release(s.channel, board=s.board)
            if self.sweep and self.sweep["id"] == sid:
                self.sweep = None

    def set_us(self, sid, us):
        if sid in self.servos and self.mode == "calib":
            self.manual_target[sid] = min(max(float(us), self.abs_lo), self.abs_hi)

    def cal(self, sid, field, value=None):
        s = self.servos.get(sid)
        if s is None:
            return
        us = self.manual_us[sid]
        if field == "center":
            s.us_center = us
        elif field == "low":
            s.us_min = min(us, s.us_max - 10)
        elif field == "high":
            s.us_max = max(us, s.us_min + 10)
        elif field == "invert":
            s.invert = bool(value)
        elif field == "scale_from":       # jog to a measured angle, enter it -> derive us/deg
            ang = abs(float(value))
            if ang > 1:
                s.us_per_deg = round(abs(us - s.us_center) / ang, 3)
        elif field in CAL_FIELDS and value is not None:
            setattr(s, field, type(getattr(s, field))(value))
        else:
            return
        self.cal_version += 1

    def start_sweep(self, sid):
        s = self.servos.get(sid)
        if s and sid in self.enabled and self.mode == "calib":
            self.sweep = {"id": sid, "wps": [s.us_center, s.us_max, s.us_min, s.us_center], "i": 0}

    # ---------------------------------------------------------------- modes / params
    def set_mode(self, mode):
        if mode not in MODES or mode == self.mode:
            return
        if self.mode == "calib":          # hand over from raw pulses to the slew limiter smoothly
            for sid in self.enabled:
                self.limiter.reset(sid, self.servos[sid].us_to_deg(self.manual_us[sid]))
        if mode == "calib":
            for sid in self.enabled:
                cur = self.limiter.cur.get(sid)
                if cur is not None:
                    self.manual_us[sid] = self.servos[sid].deg_to_us(cur)
                    self.manual_target[sid] = self.manual_us[sid]
        if mode == "legtest":
            self.leg_targets = self.gait.nominal()
        self.sweep = None
        self.cmd = (0.0, 0.0, 0.0)
        self.mode = mode
        if self.armed and mode in ("stand", "crawl", "trot") and not self.enabled:
            self.enable_servo("all", True)
            self.notice = f"Mode {mode}: all servos enabled"

    def set_params(self, msg):
        gp = self.gait.p
        for k in ("height_stand", "height_rest", "step_len", "step_height", "freq_hz", "speed_scale", "yaw_step_deg"):
            if k in msg:
                gp[k] = float(msg[k])
                self.cfg["gait"][k] = gp[k]
        for k in ("stop_mm", "slow_mm", "arc_deg", "turn_gain"):
            if k in msg:
                setattr(self.avoid, k, float(msg[k]))
                self.cfg["avoid"][k] = float(msg[k])
        if "avoid_enabled" in msg:
            self.avoid.enabled = bool(msg["avoid_enabled"])
            self.cfg["avoid"]["enabled"] = self.avoid.enabled
        if "auto_derate" in msg:
            self.auto_derate = bool(msg["auto_derate"])
            if not self.auto_derate:
                self.derate.scale = 1.0

    def save(self):
        self.cfg["servos"] = [s.to_dict() for s in self.servos.values()]
        save_cfg(self.cfg, self.cfg_path)
        self.notice = "Config saved"

    # ---------------------------------------------------------------- messages
    def handle(self, msg):
        t = msg.get("t")
        if t == "drive":
            def cl(v):
                return max(-1.0, min(1.0, float(v)))
            self.cmd = (cl(msg.get("vx", 0)), cl(msg.get("vy", 0)), cl(msg.get("wz", 0)))
            self.cmd_t = self.clock()
        elif t == "arm":
            self.arm(msg.get("on"))
        elif t == "estop":
            self.trigger_estop()
        elif t == "reset_estop":
            self.reset_estop()
        elif t == "mode":
            self.set_mode(msg.get("mode"))
        elif t == "servo_enable":
            self.enable_servo(msg.get("id"), bool(msg.get("on")))
        elif t == "servo_enable_all":
            self.enable_servo("all", bool(msg.get("on", True)))
        elif t == "quick_test":
            self.quick_test(msg.get("action"))
        elif t == "servo_us":
            self.set_us(msg.get("id"), msg.get("us"))
        elif t == "servo_cal":
            self.cal(msg.get("id"), msg.get("field"), msg.get("value"))
        elif t == "servo_sweep":
            self.start_sweep(msg.get("id"))
        elif t == "leg":
            leg = msg.get("leg")
            if leg in self.leg_targets and self.mode == "legtest":
                self.leg_targets[leg] = (float(msg["x"]), float(msg["y"]), float(msg["z"]))
        elif t == "params":
            self.set_params(msg)
        elif t == "save":
            self.save()
        elif t == "mock_obstacle" and hasattr(self.lidar, "set_obstacle"):
            self.lidar.set_obstacle(float(msg["dist_mm"]) if msg.get("on") else None)

    def quick_test(self, action):
        if not self.armed:
            self.arm(True)
        if action == "stand":
            self.set_mode("stand")
            self.enable_servo("all", True)
            self.cmd = (0.0, 0.0, 0.0)
            self.cmd_t = self.clock()
            self.notice = "Quick test: Standing pose"
        elif action == "crawl_fwd":
            self.set_mode("crawl")
            self.enable_servo("all", True)
            self.cmd = (0.6, 0.0, 0.0)
            self.cmd_t = self.clock()
            self.notice = "Quick test: Walking forward (crawl)"
        elif action == "crawl_back":
            self.set_mode("crawl")
            self.enable_servo("all", True)
            self.cmd = (-0.6, 0.0, 0.0)
            self.cmd_t = self.clock()
            self.notice = "Quick test: Walking backward"
        elif action == "turn_left":
            self.set_mode("crawl")
            self.enable_servo("all", True)
            self.cmd = (0.0, 0.0, 0.8)
            self.cmd_t = self.clock()
            self.notice = "Quick test: Turning left (CCW)"
        elif action == "turn_right":
            self.set_mode("crawl")
            self.enable_servo("all", True)
            self.cmd = (0.0, 0.0, -0.8)
            self.cmd_t = self.clock()
            self.notice = "Quick test: Turning right (CW)"
        elif action == "zero_1500":
            self.set_mode("calib")
            self.enable_servo("all", True)
            for sid in self.servos:
                self.manual_target[sid] = 1500.0
            self.notice = "Quick test: Centered at 1500 µs"
        elif action == "stop":
            self.cmd = (0.0, 0.0, 0.0)
            self.notice = "Quick test: Stopped"

    # ---------------------------------------------------------------- control tick
    def _write(self, sid, us):
        s = self.servos[sid]
        if self.out_us.get(sid) is None or abs(self.out_us[sid] - us) >= 0.5:
            try:
                self.driver.set_pulse(s.channel, us, board=s.board)
                self.out_us[sid] = us
                self._i2c_errors = 0
            except (OSError, IOError):
                self._i2c_errors = getattr(self, "_i2c_errors", 0) + 1
                if self._i2c_errors >= 8:
                    raise

    def tick(self, dt):
        t0 = time.perf_counter()
        if not self.armed or self.estop:
            self.tick_ms = 0.0
            return
        fresh = (self.clock() - self.cmd_t) < self.timeout
        cmd = self.cmd if fresh else (0.0, 0.0, 0.0)

        if self.mode == "calib":
            if self.sweep:
                sw = self.sweep
                sid, target = sw["id"], sw["wps"][sw["i"]]
                cur, step = self.manual_us[sid], self.sweep_rate * dt
                if abs(target - cur) <= step:
                    self.manual_us[sid] = target
                    sw["i"] += 1
                    if sw["i"] >= len(sw["wps"]):
                        self.sweep = None
                else:
                    self.manual_us[sid] = cur + step * (1 if target > cur else -1)
                self.manual_target[sw["id"]] = self.manual_us[sw["id"]]
            else:
                step = self.jog_rate * dt
                for sid in self.enabled:
                    d = self.manual_target[sid] - self.manual_us[sid]
                    self.manual_us[sid] += max(-step, min(step, d))
            for sid in list(self.enabled):
                s = self.servos[sid]
                us = self.manual_us[sid]     # calibration may go past the current limits (that is how you set them)
                self._write(sid, us)
                self.limiter.reset(sid, s.us_to_deg(us))
        else:
            if self.mode == "legtest":
                feet = self.leg_targets
            else:
                if self.mode in GAITS:
                    cmd, self.avoid_info = self._avoid(cmd)
                else:
                    self.avoid_info = {"state": "off", "front_mm": None, "scale": 1.0}
                feet = self.gait.update(dt, self.mode, cmd, self.derate.scale)
            targets = {}
            for leg, (x, y, z) in feet.items():
                th1, a, b, ok = self.kin.ik_deg(x, y, z)
                self.reach_ok[leg] = ok
                targets[f"{leg}_coxa"], targets[f"{leg}_femur"], targets[f"{leg}_tibia"] = th1, a, b
            for sid in list(self.enabled):
                s = self.servos[sid]
                deg = self.limiter.step(s, targets[sid], dt)
                self._write(sid, s.deg_to_us(deg))
            if self.mode in GAITS and self.enabled:
                worst = max(self.limiter.sat.get(sid, 0.0) for sid in self.enabled)
                moving = max(abs(c) for c in self.gait.cs) > 0.3
                self.derate.update(worst, dt, active=self.auto_derate and moving)
        self.tick_ms = (time.perf_counter() - t0) * 1000.0

    def _avoid(self, cmd):
        scan, age = self.lidar.snapshot()
        return avoidmod.apply(scan, age, cmd, self.avoid)

    # ---------------------------------------------------------------- state out
    def cal_message(self):
        boards = list(self.cfg.get("pca9685", {}).get("boards", {}).keys())
        return {
            "t": "cal",
            "version": self.cal_version,
            "servos": [s.to_dict() | {"deg_lo": s.deg_range()[0], "deg_hi": s.deg_range()[1]} for s in self.servos.values()],
            "boards": boards,
            "geometry": self.cfg["geometry"],
            "legs": self.cfg["legs"],
            "gait": self.cfg["gait"],
            "avoid": asdict(self.avoid),
            "reach": self.gait.reach,
            "pulse_abs": [self.abs_lo, self.abs_hi],
            "modes": list(MODES),
        }

    def state_message(self):
        live = {}
        for sid, s in self.servos.items():
            us = self.manual_us[sid] if self.mode == "calib" else self.out_us.get(sid, s.deg_to_us(self.limiter.cur.get(sid, 0.0)))
            live[sid] = {
                "en": sid in self.enabled,
                "us": round(us, 1),
                "deg": round(s.us_to_deg(us), 1),
                "sat": round(self.limiter.sat.get(sid, 0.0), 2),
                "clamp": round(self.limiter.clamp.get(sid, 0.0), 2),
            }
        return {
            "t": "state",
            "armed": self.armed,
            "estop": self.estop,
            "mode": self.mode,
            "num_enabled": len(self.enabled),
            "total_servos": len(self.servos),
            "cal_version": self.cal_version,
            "notice": self.notice,
            "live": live,
            "gait_scale": round(self.derate.scale, 2),
            "auto_derate": self.auto_derate,
            "swing": self.gait.swing,
            "reach_ok": self.reach_ok,
            "avoid": self.avoid_info,
            "avoid_enabled": self.avoid.enabled,
            "lidar": self.lidar.status,
            "cmd": [round(c, 2) for c in self.cmd],
            "tick_ms": round(self.tick_ms, 2),
            "leg_targets": {k: [round(v, 1) for v in t] for k, t in self.leg_targets.items()},
        }
