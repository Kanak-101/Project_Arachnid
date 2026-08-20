"""
gait_engine.py  –  Project Arachnid
Tripod gait controller with simple analytical IK.

Hexapod leg numbering (top view, X = forward):
         FRONT
    L6 ──── L1
    L5        L2
    L4 ──── L3
         BACK

Tripod groups:
  Group A (swing together): L1, L3, L5
  Group B (swing together): L2, L4, L6

Gait cycle per step:
  1. Group A lifts, swings forward   → Group B stance (pushes body)
  2. Group A plants                  → swap roles

Segment lengths (from URDF, metres):
  Coxa  : 0.033 m  (J1→J2 offset)
  Femur : 0.102 m
  Tibia : 0.102 m
"""

import math
import time
import threading
from servo_driver import set_all_legs, go_neutral, NEUTRAL

# ── Geometry ──────────────────────────────────────────────────────────────────
L_COXA  = 0.033
L_FEMUR = 0.102
L_TIBIA = 0.102

# ── Gait parameters (tune after first test) ───────────────────────────────────
STEP_LENGTH   = 0.035   # metres per step (forward distance foot travels)
STEP_HEIGHT   = 0.030   # lift height during swing phase (metres)
BODY_HEIGHT   = 0.080   # target foot height below body centre
CYCLE_TIME    = 0.5     # seconds for one full tripod cycle (lower = faster)
TURN_STEP_DEG = 12.0    # degrees body rotates per gait cycle

# ── Leg home positions in body frame (x forward, y left, z down) ──────────────
# These are the neutral foot-tip positions relative to body centre.
# Derived from body attachment points in URDF.
HOME = {
    1: ( 0.155, -0.155, BODY_HEIGHT),   # Front-right
    2: ( 0.000, -0.180, BODY_HEIGHT),   # Right
    3: (-0.155, -0.155, BODY_HEIGHT),   # Back-right
    4: (-0.155,  0.155, BODY_HEIGHT),   # Back-left
    5: ( 0.000,  0.180, BODY_HEIGHT),   # Left
    6: ( 0.155,  0.155, BODY_HEIGHT),   # Front-left
}

# ── Tripod groups ─────────────────────────────────────────────────────────────
GROUP_A = [1, 3, 5]
GROUP_B = [2, 4, 6]

# ── Body attachment angles (yaw of each leg from URDF L*_J1 origins) ──────────
ATTACH_ANGLE = {
    1: -math.pi / 4,        # -45°  front-right
    2: -math.pi / 2,        # -90°  right
    3: -3 * math.pi / 4,    # -135° back-right
    4:  3 * math.pi / 4,    # +135° back-left
    5:  math.pi / 2,        # +90°  left
    6:  math.pi / 4,        # +45°  front-left
}


# ── Analytical IK ─────────────────────────────────────────────────────────────
def ik(leg: int, foot_x: float, foot_y: float, foot_z: float):
    """
    Given desired foot tip position in body frame,
    return (j1_rad, j2_rad, j3_rad).

    foot_z is positive downward (depth below body).
    Returns None if target is unreachable.
    """
    # ── J1: coxa yaw ──────────────────────────────────────────────────────────
    dx = foot_x
    dy = foot_y
    j1 = math.atan2(dy, dx) - ATTACH_ANGLE[leg]
    # Normalise to [-pi, pi]
    j1 = (j1 + math.pi) % (2 * math.pi) - math.pi

    # ── Project into leg plane ────────────────────────────────────────────────
    # Horizontal distance from coxa pivot to foot
    r_body = math.hypot(dx, dy)
    r_leg  = r_body - L_COXA          # horizontal reach from femur pivot
    z_leg  = foot_z                   # vertical reach (downward positive)

    reach  = math.hypot(r_leg, z_leg)

    # Check reachability
    if reach > (L_FEMUR + L_TIBIA) * 0.99:
        reach = (L_FEMUR + L_TIBIA) * 0.99   # clamp to max reach

    if reach < abs(L_FEMUR - L_TIBIA):
        return None  # too close

    # ── J3: tibia angle (law of cosines) ─────────────────────────────────────
    cos_j3 = (L_FEMUR**2 + L_TIBIA**2 - reach**2) / (2 * L_FEMUR * L_TIBIA)
    cos_j3 = max(-1.0, min(1.0, cos_j3))
    j3 = math.acos(cos_j3) - math.pi   # negative = knee bent downward

    # ── J2: femur angle ───────────────────────────────────────────────────────
    alpha = math.atan2(z_leg, r_leg)
    beta  = math.acos(max(-1.0, min(1.0,
              (L_FEMUR**2 + reach**2 - L_TIBIA**2) / (2 * L_FEMUR * reach)
            )))
    j2 = alpha + beta

    return j1, j2, j3


# ── Current foot positions (updated during gait) ─────────────────────────────
_foot_pos = {leg: list(HOME[leg]) for leg in range(1, 7)}
_gait_running = False
_gait_thread  = None
_gait_lock    = threading.Lock()


def _move_feet(targets: dict, steps: int = 6):
    """
    Interpolate all feet from current positions to targets over `steps` frames.
    targets = { leg: (x, y, z) }
    """
    starts  = {leg: list(_foot_pos[leg]) for leg in targets}
    for s in range(1, steps + 1):
        t       = s / steps
        angles  = {}
        for leg in range(1, 7):
            if leg in targets:
                x = starts[leg][0] + (_foot_pos[leg][0] - starts[leg][0]) if False else \
                    starts[leg][0] + (targets[leg][0] - starts[leg][0]) * t
                y = starts[leg][1] + (targets[leg][1] - starts[leg][1]) * t
                z = starts[leg][2] + (targets[leg][2] - starts[leg][2]) * t
            else:
                x, y, z = _foot_pos[leg]

            result = ik(leg, x, y, z)
            if result:
                angles[leg] = result

        set_all_legs(angles)
        time.sleep(CYCLE_TIME / (2 * steps))

    # Commit final positions
    for leg, pos in targets.items():
        _foot_pos[leg] = list(pos)


def _tripod_step(swing_group: list, stance_group: list,
                 dx: float, dy: float, dyaw: float):
    """
    One half of the tripod gait cycle.
    swing_group swings forward; stance_group pushes body.
    dx, dy : body translation per half-cycle (metres)
    dyaw   : body rotation per half-cycle (radians)
    """
    STEPS = 8

    swing_targets  = {}
    stance_targets = {}

    for leg in swing_group:
        hx, hy, hz = HOME[leg]
        # Swing foot arc: lift + move to home + plant
        # Simplified: go to home position with lift added
        swing_targets[leg] = (hx, hy, hz)

    for leg in stance_group:
        cx, cy, cz = _foot_pos[leg]
        # Stance: foot stays on ground, body moves → foot moves opposite
        # Rotate
        cos_y = math.cos(-dyaw)
        sin_y = math.sin(-dyaw)
        nx = cx * cos_y - cy * sin_y - dx
        ny = cx * sin_y + cy * cos_y - dy
        stance_targets[leg] = (nx, ny, cz)

    starts = {leg: list(_foot_pos[leg]) for leg in range(1, 7)}

    for s in range(1, STEPS + 1):
        t      = s / STEPS
        t_lift = math.sin(math.pi * t)   # 0→1→0 arc for swing
        angles = {}
        for leg in range(1, 7):
            if leg in swing_group:
                tx, ty, tz = swing_targets[leg]
                sx, sy, sz = starts[leg]
                x = sx + (tx - sx) * t
                y = sy + (ty - sy) * t
                z = tz - STEP_HEIGHT * t_lift
            else:
                tx, ty, tz = stance_targets[leg]
                sx, sy, sz = starts[leg]
                x = sx + (tx - sx) * t
                y = sy + (ty - sy) * t
                z = sz

            result = ik(leg, x, y, z)
            if result:
                angles[leg] = result

        set_all_legs(angles)
        time.sleep(CYCLE_TIME / (2 * STEPS))

    for leg, pos in swing_targets.items():
        _foot_pos[leg] = list(pos)
    for leg, pos in stance_targets.items():
        _foot_pos[leg] = list(pos)


# ── Public gait commands ──────────────────────────────────────────────────────

def stand():
    """Move all feet to home standing position."""
    targets = {leg: HOME[leg] for leg in range(1, 7)}
    _move_feet(targets, steps=12)
    print("[gait] Standing.")


def walk(dx: float, dy: float, dyaw: float, cycles: int = 1):
    """
    Walk with given velocity vector for `cycles` tripod cycles.
    dx   : forward (+) / backward (-)  metres per cycle
    dy   : strafe left (+) / right (-) metres per cycle
    dyaw : turn CCW (+) / CW (-)       radians per cycle
    """
    for _ in range(cycles):
        _tripod_step(GROUP_A, GROUP_B,  dx / 2,  dy / 2,  dyaw / 2)
        _tripod_step(GROUP_B, GROUP_A,  dx / 2,  dy / 2,  dyaw / 2)


def step_single_leg(leg: int, dx: float, dy: float, dz: float):
    """
    Move a single leg's foot tip by delta in body frame.
    Used in Mode 2 (single-leg control).
    """
    cx, cy, cz = _foot_pos[leg]
    tx, ty, tz = cx + dx, cy + dy, cz + dz
    targets    = {leg: (tx, ty, tz)}
    _move_feet(targets, steps=6)
