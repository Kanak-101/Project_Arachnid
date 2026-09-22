"""Kinematic gait engine: crawl and trot, plus stand and rest poses.

Produces foot targets (leg frame) for the four legs from a normalised drive command
(vx forward, vy left, wz counter-clockwise, each in -1..1). The CPG will later plug in
here by supplying the phase and per-leg offsets instead of the fixed ones below.
"""
import math

GAITS = {
    # duty = fraction of the cycle a foot is on the ground; offsets = phase lag per leg
    "crawl": {"duty_key": "duty_crawl", "offsets": {"FL": 0.0, "RR": 0.25, "FR": 0.5, "RL": 0.75}},
    "trot": {"duty_key": "duty_trot", "offsets": {"FL": 0.0, "RR": 0.0, "FR": 0.5, "RL": 0.5}},
}


class GaitEngine:
    def __init__(self, cfg):
        self.legs = cfg["legs"]
        self.p = dict(cfg["gait"])
        g = cfg["geometry"]
        self.reach = self.p.get("stance_reach", g["coxa"] + g["femur"])
        self.phase = 0.0
        self.height = self.p["height_rest"]
        self.cs = [0.0, 0.0, 0.0]          # smoothed command
        self.swing = []                    # legs currently in swing (for telemetry)

    def nominal(self, height=None):
        h = self.height if height is None else height
        return {leg: (self.reach, 0.0, -h) for leg in self.legs}

    def update(self, dt, mode, cmd, freq_scale=1.0):
        p = self.p
        target_h = p["height_rest"] if mode == "rest" else p["height_stand"]
        self.height += (target_h - self.height) * (1 - math.exp(-dt / 0.4))

        moving = mode in GAITS
        tgt = cmd if moving else (0.0, 0.0, 0.0)
        a = 1 - math.exp(-dt / 0.2)
        self.cs = [c + a * (t - c) for c, t in zip(self.cs, tgt)]
        vx, vy, wz = self.cs
        mag = max(math.hypot(vx, vy), abs(wz))
        mag = min(mag, 1.0)
        activity = min(1.0, mag * 4.0)

        gait = GAITS.get(mode, GAITS["crawl"])
        duty = p[gait["duty_key"]]
        if mag > 0.02:
            self.phase = (self.phase + dt * p["freq_hz"] * p["speed_scale"] * freq_scale) % 1.0

        step_len, step_h = p["step_len"], p["step_height"]
        psi = wz * math.radians(p["yaw_step_deg"])
        feet, self.swing = {}, []
        for leg, geo in self.legs.items():
            side = geo["side"]
            hx, hy = geo["hip_xy"]
            rx, ry = hx + 0.0, hy + side * self.reach           # nominal foot in body frame
            # foot displacement over one stance, in the body frame (body moves +D, foot moves -D)
            dx = -vx * step_len + psi * ry
            dy = -vy * step_len - psi * rx
            ph = (self.phase + gait["offsets"][leg]) % 1.0
            if ph < duty:                                          # stance: foot slides backward
                s = ph / duty
                off = -0.5 + s
                lift = 0.0
            else:                                                  # swing: foot arcs forward
                u = (ph - duty) / (1 - duty)
                off = 0.5 - 0.5 * (1 - math.cos(math.pi * u))
                lift = step_h * math.sin(math.pi * u) * activity
                if lift > 1.0:
                    self.swing.append(leg)
            ox, oy = dx * off, dy * off
            # body-frame offset -> leg frame (x outward, y forward)
            feet[leg] = (self.reach + side * oy, ox, -self.height + lift)
        return feet
