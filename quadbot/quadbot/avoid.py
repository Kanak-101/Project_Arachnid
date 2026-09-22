"""Reactive obstacle avoidance on top of the drive command.

Looks at the lidar arc in the direction of travel. Slows the command as something gets
close, stops translation inside `stop_mm`, and turns toward the side with more room.
Fails safe: if the scan is stale, translation is stopped.
"""
from dataclasses import dataclass

import numpy as np


@dataclass
class AvoidParams:
    enabled: bool = True
    stop_mm: float = 350
    slow_mm: float = 900
    arc_deg: float = 35
    min_range_mm: float = 120
    turn_gain: float = 0.8
    max_age_s: float = 0.6


def sector_min(scan, center_deg, half_deg, min_range):
    idx = (np.arange(-int(half_deg), int(half_deg) + 1) + int(round(center_deg))) % 360
    d = scan[idx]
    d = d[d > min_range]
    return float(d.min()) if d.size else float("inf")


def apply(scan, age_s, cmd, p: AvoidParams):
    """Return (new_cmd, info). cmd = (vx, vy, wz), each in -1..1."""
    vx, vy, wz = cmd
    if not p.enabled:
        return cmd, {"state": "off", "front_mm": None, "scale": 1.0}

    trans = float(np.hypot(vx, vy))
    if age_s > p.max_age_s:
        return (0.0, 0.0, wz), {"state": "lidar_lost", "front_mm": None, "scale": 0.0}

    heading = float(np.degrees(np.arctan2(vy, vx))) % 360 if trans > 0.05 else 0.0
    front = sector_min(scan, heading, p.arc_deg, p.min_range_mm)
    if trans <= 0.05:
        return cmd, {"state": "idle", "front_mm": front, "scale": 1.0}

    scale = float(np.clip((front - p.stop_mm) / (p.slow_mm - p.stop_mm), 0.0, 1.0))
    out_wz = wz
    if scale < 1.0 and np.cos(np.radians(heading)) > 0.3:      # steering only makes sense going forward
        inner, outer = p.arc_deg + 5, 100.0          # compare the room on each side, just outside the front arc
        centre, half = (inner + outer) / 2, (outer - inner) / 2
        left = sector_min(scan, heading + centre, half, p.min_range_mm)
        right = sector_min(scan, heading - centre, half, p.min_range_mm)
        turn = 1.0 if left >= right else -1.0                 # + = counter-clockwise = to the left
        out_wz = float(np.clip(wz + turn * p.turn_gain * (1.0 - scale), -1.0, 1.0))
    state = "blocked" if scale <= 0.0 else ("slow" if scale < 1.0 else "clear")
    return (vx * scale, vy * scale, out_wz), {"state": state, "front_mm": front, "scale": scale}
