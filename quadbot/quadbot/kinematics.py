"""3-DoF leg kinematics.

Leg frame (per leg, mirrored for left/right so one set of equations serves all four):
    x = outward from the body, y = forward, z = up, origin at the hip (coxa) axis.

Joint angles are measured from the calibration pose, which is the pose you set each
servo's centre at: coxa pointing straight out, femur horizontal, tibia vertical.
    coxa  +  : leg swings forward
    femur +  : femur lifts up
    tibia +  : knee opens, foot moves outward
The servo `invert` flag maps these to whichever way the physical servo turns.
"""
import math
from dataclasses import dataclass


@dataclass
class LegKinematics:
    coxa: float
    femur: float
    tibia: float

    def fk(self, th1, a, b):
        """Angles in radians -> foot (x, y, z) in the leg frame."""
        g = a - math.pi / 2 + b                      # absolute direction of the tibia
        r = self.coxa + self.femur * math.cos(a) + self.tibia * math.cos(g)
        z = self.femur * math.sin(a) + self.tibia * math.sin(g)
        return r * math.cos(th1), r * math.sin(th1), z

    def ik(self, x, y, z):
        """Foot target -> (coxa, femur, tibia) in radians, plus a reachable flag."""
        th1 = math.atan2(y, x)
        r = math.hypot(x, y) - self.coxa
        d = math.hypot(r, z)
        lo, hi = abs(self.femur - self.tibia) + 1e-3, self.femur + self.tibia - 1e-3
        reachable = lo <= d <= hi
        dc = min(max(d, lo), hi)
        delta = math.atan2(z, r)
        cos_eps = (self.femur ** 2 + dc ** 2 - self.tibia ** 2) / (2 * self.femur * dc)
        cos_kap = (self.femur ** 2 + self.tibia ** 2 - dc ** 2) / (2 * self.femur * self.tibia)
        eps = math.acos(max(-1.0, min(1.0, cos_eps)))
        kap = math.acos(max(-1.0, min(1.0, cos_kap)))
        return th1, delta + eps, kap - math.pi / 2, reachable

    def ik_deg(self, x, y, z):
        th1, a, b, ok = self.ik(x, y, z)
        return math.degrees(th1), math.degrees(a), math.degrees(b), ok
