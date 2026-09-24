"""The robot controller: one place that owns safety state, modes and the control tick.

Safety rules, in order of importance:
  * Nothing moves until the robot is ARMED, and a servo only gets pulses once you
    enable that individual servo. Disabled servos are released (limp).
  * E-stop and disarm release every channel immediately.
  * No fresh drive command for `command_timeout_s` -> the drive command falls to zero.
  * Pulses are clamped to each servo's calibrated hard limits and speed-limited.
"""
import math
import time
from dataclasses import asdict

from . import avoid as avoidmod
from .battery import make_battery_reader
from .config import save as save_cfg
from .gait import GaitEngine, GAITS
from .kinematics import LegKinematics
from .servos import AutoDerate, ServoCal, SlewLimiter

MODES = ("calib", "legtest", "rest", "stand", "crawl", "trot")
MODES = ("calib", "legtest", "rest", "stand", "crawl", "trot", "pace", "bound", "pronk", "wave")
CAL_FIELDS = ("channel", "board", "us_per_deg", "max_speed_dps", "deg_min", "deg_max")


class Robot:
    def __init__(self, cfg, cfg_path, driver, lidar, clock=time.monotonic, battery=None):
        self.clock = clock                  # injectable so tests can fast-forward the watchdog
        self.cfg, self.cfg_path = cfg, cfg_path
        self.driver, self.lidar = driver, lidar
        self.battery = battery if battery is not None else make_battery_reader(cfg)
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
        self.neutral_deg = self._ik_targets(self.gait.nominal(cfg["gait"]["height_stand"]))
        self.wave_phase = None
        self.palm_detected = False
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

    def _ik_targets(self, feet):
        targets = {}
        for leg, (x, y, z) in feet.items():
            th1, a, b, _ = self.kin.ik_deg(x, y, z)
            targets[f"{leg}_coxa"] = th1
            targets[f"{leg}_femur"] = a
            targets[f"{leg}_tibia"] = b
        return targets

    # ---------------------------------------------------------------- safety
    def arm(self, on):
        if on and self.estop:
            self.notice = "E-stop is latched: reset it first"
            return
        self.armed = bool(on)
        if not self.armed:
            self._release_all()
        else:
            if self.mode in ("stand", "crawl", "trot") and not self.enabled:
                self.enable_servo("all", True)
                self.notice = f"Armed: All 12 servos active for {self.mode}"
            else:
                self.notice = "Armed. Select leg or servos to enable."

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

    def enable_leg(self, leg, on=True, exclusive=False):
        """Enable or disable all 3 servos of a single leg (coxa, femur, tibia).
        If exclusive=True, releases all other servos first so only this leg draws power."""
        if not self.armed and on:
            self.notice = "Arm the robot before enabling servos"
            return
        if exclusive and on:
            self._release_all()
            self.armed = True
        for j in ("coxa", "femur", "tibia"):
            sid = f"{leg}_{j}"
            if sid in self.servos:
                self.enable_servo(sid, on)
        self.notice = f"{'Enabled' if on else 'Disabled'} leg {leg} ({len(self.enabled)} active servos)"

    def enable_board(self, board, on=True, exclusive=False):
        """Enable or disable all servos on one PCA board ('left' or 'right')."""
        if not self.armed and on:
            self.notice = "Arm the robot before enabling servos"
            return
        if exclusive and on:
            self._release_all()
            self.armed = True
        for s in self.servos.values():
            if s.board == board:
                self.enable_servo(s.id, on)
        self.notice = f"{'Enabled' if on else 'Disabled'} {board} board ({len(self.enabled)} active servos)"

    def enable_only(self, sid):
        """Release all other servos and enable ONLY this single servo (for safe low-power testing)."""
        if not self.armed:
            self.notice = "Arm the robot before enabling servos"
            return
        self._release_all()
        self.armed = True
        self.enable_servo(sid, True)
        self.notice = f"Enabled ONLY {sid} (1 servo active, low power safe)"

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
            pulse_delta = abs(us - s.us_center)
            if ang > 1 and pulse_delta >= 1:
                s.us_per_deg = round(pulse_delta / ang, 3)
            elif ang > 1:
                self.notice = "Move the servo away from centre before calibrating scale"
                return
        elif field in CAL_FIELDS and value is not None:
            setattr(s, field, type(getattr(s, field))(value))
        else:
            return
        self.cal_version += 1

    def start_sweep(self, sid, speed_us_s=None):
        s = self.servos.get(sid)
        if s and sid in self.enabled and self.mode == "calib":
            speed = self.sweep_rate if speed_us_s is None else max(1.0, min(float(speed_us_s), 5000.0))
            self.sweep = {"id": sid, "wps": [s.us_center, s.us_max, s.us_min, s.us_center], "i": 0, "speed_us_s": speed}

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
        if mode != "wave":
            self.wave_phase = None
        if self.armed and mode in ("stand", "crawl", "trot", "pace", "bound", "pronk", "wave") and not self.enabled:
            self.enable_leg("FL", True)
            self.notice = f"Mode {mode}: Front-Left (FL) leg enabled (safe low-power)"

    def set_params(self, msg):
        gp = self.gait.p
        for k in ("height_stand", "height_rest", "stance_reach", "step_len", "step_height", "freq_hz", "speed_scale", "step_speed", "stride_scale", "lift_scale", "coxa_gain", "yaw_step_deg", "turn_scale"):
            if k in msg:
                gp[k] = float(msg[k])
                self.cfg["gait"][k] = gp[k]
        self.gait.reach = float(gp.get("stance_reach", self.gait.reach))
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
            vx, vy, wz = cl(msg.get("vx", 0)), cl(msg.get("vy", 0)), cl(msg.get("wz", 0))
            if math.hypot(vx, vy) < 0.04 and abs(wz) < 0.04:
                vx, vy, wz = 0.0, 0.0, 0.0
            self.cmd = (vx, vy, wz)
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
        elif t == "enable_leg":
            self.enable_leg(msg.get("leg"), bool(msg.get("on", True)), bool(msg.get("exclusive", False)))
        elif t == "enable_board":
            self.enable_board(msg.get("board"), bool(msg.get("on", True)), bool(msg.get("exclusive", False)))
        elif t == "enable_only":
            self.enable_only(msg.get("id"))
        elif t == "quick_test":
            self.quick_test(msg.get("action"), target=msg.get("target"))
        elif t == "servo_us":
            self.set_us(msg.get("id"), msg.get("us"))
        elif t == "servo_cal":
            self.cal(msg.get("id"), msg.get("field"), msg.get("value"))
        elif t == "servo_sweep":
            self.start_sweep(msg.get("id"), msg.get("speed_us_s"))
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
        elif t == "palm":
            detected = bool(msg.get("detected", False))
            if detected and not self.palm_detected and not self.estop:
                self.set_mode("wave")
                self.wave_phase = 0.0
                self.cmd_t = self.clock()
            self.palm_detected = detected
        elif t == "action" and msg.get("action") == "wave":
            self.set_mode("wave")
            self.wave_phase = 0.0
            self.cmd_t = self.clock()

    def quick_test(self, action, target=None):
        if not self.armed:
            self.arm(True)
        if target:
            if target == "all":
                self.enable_servo("all", True)
            elif target in ("FL", "FR", "RL", "RR"):
                self.enable_leg(target, True, exclusive=True)
            elif target in ("left", "right"):
                self.enable_board(target, True, exclusive=True)
            elif target in self.servos:
                self.enable_only(target)
        elif not self.enabled:
            self.enable_leg("FL", True, exclusive=True)

        count_desc = f"{len(self.enabled)} active" if len(self.enabled) < 12 else "all 12 active"
        if action == "stand":
            self.set_mode("stand")
            self.cmd = (0.0, 0.0, 0.0)
            self.cmd_t = self.clock()
            self.notice = f"Stand pose ({count_desc})"
        elif action == "crawl_fwd":
            self.set_mode("crawl")
            self.cmd = (0.6, 0.0, 0.0)
            self.cmd_t = self.clock()
            self.notice = f"Walking forward ({count_desc})"
        elif action == "crawl_back":
            self.set_mode("crawl")
            self.cmd = (-0.6, 0.0, 0.0)
            self.cmd_t = self.clock()
            self.notice = f"Walking backward ({count_desc})"
        elif action == "turn_left":
            self.set_mode("crawl")
            self.cmd = (0.0, 0.0, 0.8)
            self.cmd_t = self.clock()
            self.notice = f"Turning left ({count_desc})"
        elif action == "turn_right":
            self.set_mode("crawl")
            self.cmd = (0.0, 0.0, -0.8)
            self.cmd_t = self.clock()
            self.notice = f"Turning right ({count_desc})"
        elif action == "zero_1500":
            self.set_mode("calib")
            for sid in self.servos:
                self.manual_target[sid] = 1500.0
            self.notice = f"Centered to 1500 µs ({count_desc})"
        elif action == "stop":
            self.cmd = (0.0, 0.0, 0.0)
            self.notice = "Quick test: Stopped"

    # ---------------------------------------------------------------- control tick
    def _write(self, sid, us):
        s = self.servos[sid]
        # 1.5 us deadband prevents high-gain digital servos (like MG958 coxa) from micro-hunting
        if self.out_us.get(sid) is None or abs(self.out_us[sid] - us) >= 1.5:
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
                cur, step = self.manual_us[sid], sw["speed_us_s"] * dt
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
            elif self.mode == "wave":
                self.wave_phase = min(3.0, (self.wave_phase or 0.0) + dt * 1.4)
                feet = self.gait.nominal(self.gait.height)
                u = self.wave_phase % 1.0
                feet["FL"] = (feet["FL"][0], feet["FL"][1] + 45.0 * math.sin(math.pi * u), feet["FL"][2] + 45.0 * math.sin(math.pi * u))
                if self.wave_phase >= 3.0:
                    self.set_mode("stand")
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
                targets[f"{leg}_coxa"] = th1 - self.neutral_deg[f"{leg}_coxa"]
                targets[f"{leg}_femur"] = a - self.neutral_deg[f"{leg}_femur"]
                targets[f"{leg}_tibia"] = b - self.neutral_deg[f"{leg}_tibia"]
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
        if not self.avoid.enabled:
            return cmd, {"state": "off", "front_mm": None, "scale": 1.0}
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
            "enabled_list": list(self.enabled),
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
            "battery": self.battery.read() if self.battery else None,
        }
