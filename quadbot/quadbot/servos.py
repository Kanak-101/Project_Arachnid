"""Per-servo calibration model, slew limiting and automatic gait derating."""
import math
from dataclasses import dataclass, asdict


@dataclass
class ServoCal:
    id: str
    leg: str
    joint: str
    model: str
    channel: int
    us_min: float          # hard pulse limits: never commanded outside these
    us_max: float
    us_center: float       # pulse at the calibration pose (0 deg)
    us_per_deg: float      # pulse change per degree of joint motion
    invert: bool = False
    max_speed_dps: float = 120.0
    deg_min: float = -90.0  # extra soft limits in joint degrees
    deg_max: float = 90.0
    board: str = "default"

    @classmethod
    def from_dict(cls, d):
        fields = cls.__dataclass_fields__
        return cls(**{k: v for k, v in d.items() if k in fields})

    def to_dict(self):
        return asdict(self)

    @property
    def sign(self):
        return -1.0 if self.invert else 1.0

    def deg_to_us(self, deg):
        us = self.us_center + self.sign * deg * self.us_per_deg
        return min(max(us, self.us_min), self.us_max)

    def us_to_deg(self, us):
        return self.sign * (us - self.us_center) / self.us_per_deg

    def deg_range(self):
        a, b = self.us_to_deg(self.us_min), self.us_to_deg(self.us_max)
        lo, hi = min(a, b), max(a, b)
        return max(lo, self.deg_min), min(hi, self.deg_max)


class SlewLimiter:
    """Keeps every joint inside its limits and below its rated speed.

    It also records how often each joint was clamped or speed-limited (an exponential
    moving average). Those numbers are what the auto-derate uses, and what the
    dashboard shows, to tell you which servo is holding the gait back.
    """

    def __init__(self, tau_s=0.5):
        self.cur = {}
        self.sat = {}     # fraction of recent time the joint was speed-limited
        self.clamp = {}   # fraction of recent time the target was outside the limits
        self.tau = tau_s

    def reset(self, sid, deg):
        self.cur[sid] = deg

    def step(self, servo: ServoCal, target_deg, dt):
        lo, hi = servo.deg_range()
        t = min(max(target_deg, lo), hi)
        clamped = abs(t - target_deg) > 1e-6
        cur = self.cur.get(servo.id)
        if cur is None:
            cur = min(max(0.0, lo), hi)
        max_step = servo.max_speed_dps * dt
        delta = t - cur
        saturated = abs(delta) > max_step + 1e-9
        new = cur + max(-max_step, min(max_step, delta))
        self.cur[servo.id] = new
        a = 1.0 - math.exp(-dt / self.tau)
        self.sat[servo.id] = self.sat.get(servo.id, 0.0) + a * ((1.0 if saturated else 0.0) - self.sat.get(servo.id, 0.0))
        self.clamp[servo.id] = self.clamp.get(servo.id, 0.0) + a * ((1.0 if clamped else 0.0) - self.clamp.get(servo.id, 0.0))
        return new


class AutoDerate:
    """Slows the gait when any servo cannot keep up, and speeds it back up when they all can.

    This is the "adjust the gait to the servos we actually have" loop: the MG995s and
    MG996Rs are slower than the MG958s, so the slowest joint sets the pace.
    """

    def __init__(self, floor=0.25):
        self.scale = 1.0
        self.floor = floor

    def update(self, worst_sat, dt, active=True):
        if not active:
            return self.scale
        if worst_sat > 0.10:
            self.scale = max(self.floor, self.scale - 0.25 * dt)
        elif worst_sat < 0.02:
            self.scale = min(1.0, self.scale + 0.05 * dt)
        return self.scale
