"""
servo_driver.py  –  Project Arachnid
Low-level PCA9685 interface for 18 MG996R servos.

Wiring layout (2 × PCA9685 boards):
  Board A  I2C addr 0x40  –  Legs 1, 2, 3  (channels 0-8)
  Board B  I2C addr 0x41  –  Legs 4, 5, 6  (channels 0-8)

Each leg uses 3 channels:  J1=coxa, J2=femur, J3=tibia
  Leg 1 → Board A  ch 0,1,2
  Leg 2 → Board A  ch 3,4,5
  Leg 3 → Board A  ch 6,7,8
  Leg 4 → Board B  ch 0,1,2
  Leg 5 → Board B  ch 3,4,5
  Leg 6 → Board B  ch 6,7,8

MG996R PWM spec:
  Frequency : 50 Hz
  Min pulse  : 500 µs  → 0°
  Mid pulse  : 1500 µs → 90°  (neutral)
  Max pulse  : 2500 µs → 180°

Install deps:
  pip3 install adafruit-circuitpython-pca9685 adafruit-circuitpython-servokit
"""

import math
import time
from adafruit_servokit import ServoKit

# ── PCA9685 boards ────────────────────────────────────────────────────────────
BOARD_A_ADDR = 0x40   # Legs 1-3
BOARD_B_ADDR = 0x41   # Legs 4-6

SERVO_FREQ_HZ     = 50
PULSE_MIN_US      = 500
PULSE_MAX_US      = 2500
SERVO_RANGE_DEG   = 180

# ── Joint angle limits (radians, from URDF) ──────────────────────────────────
JOINT_LIMITS = {
    "J1": (-1.047,  1.047),   # coxa   ±60°
    "J2": (-0.524,  1.571),   # femur  -30° to +90°
    "J3": (-1.047,  0.524),   # tibia  -60° to +30°
}

# ── Neutral pose (radians) ───────────────────────────────────────────────────
NEUTRAL = {
    "J1": 0.0,
    "J2": 0.3,    # slight forward lean so feet clear ground
    "J3": -0.5,
}

# ── Channel map:  servo_index → (kit_object, channel) ────────────────────────
# servo_index = (leg_number - 1) * 3 + joint_index
#   joint_index: 0=J1, 1=J2, 2=J3

_kit_a = None
_kit_b = None


def init_servos():
    """Initialise both PCA9685 boards. Call once at startup."""
    global _kit_a, _kit_b
    _kit_a = ServoKit(channels=16, address=BOARD_A_ADDR)
    _kit_b = ServoKit(channels=16, address=BOARD_B_ADDR)
    for kit in (_kit_a, _kit_b):
        for ch in range(9):
            kit.servo[ch].set_pulse_width_range(PULSE_MIN_US, PULSE_MAX_US)
            kit.servo[ch].actuation_range = SERVO_RANGE_DEG
    print("[servo_driver] PCA9685 boards initialised.")


def _get_kit_and_channel(leg: int, joint: int):
    """
    leg   : 1-6
    joint : 1=J1(coxa), 2=J2(femur), 3=J3(tibia)
    Returns (ServoKit, channel_number)
    """
    if leg <= 3:
        kit = _kit_a
        ch  = (leg - 1) * 3 + (joint - 1)
    else:
        kit = _kit_b
        ch  = (leg - 4) * 3 + (joint - 1)
    return kit, ch


def _clamp_rad(rad: float, joint_name: str) -> float:
    lo, hi = JOINT_LIMITS[joint_name]
    return max(lo, min(hi, rad))


def rad_to_deg(rad: float) -> float:
    """Map radian angle to 0-180° servo range (centre = 90°)."""
    deg = math.degrees(rad) + 90.0
    return max(0.0, min(180.0, deg))


def set_joint_rad(leg: int, joint: int, angle_rad: float):
    """
    Move a single joint.
    leg   : 1-6
    joint : 1(coxa) | 2(femur) | 3(tibia)
    angle_rad : target angle in radians
    """
    joint_name = f"J{joint}"
    angle_rad  = _clamp_rad(angle_rad, joint_name)
    deg        = rad_to_deg(angle_rad)
    kit, ch    = _get_kit_and_channel(leg, joint)
    kit.servo[ch].angle = deg


def set_leg(leg: int, j1_rad: float, j2_rad: float, j3_rad: float):
    """Set all three joints of a leg simultaneously."""
    set_joint_rad(leg, 1, j1_rad)
    set_joint_rad(leg, 2, j2_rad)
    set_joint_rad(leg, 3, j3_rad)


def set_all_legs(angles: dict):
    """
    angles = { leg_num: (j1, j2, j3) }  all in radians
    """
    for leg, (j1, j2, j3) in angles.items():
        set_leg(leg, j1, j2, j3)


def go_neutral():
    """Send all legs to standing neutral pose."""
    for leg in range(1, 7):
        set_leg(leg, NEUTRAL["J1"], NEUTRAL["J2"], NEUTRAL["J3"])
    print("[servo_driver] Neutral pose set.")


def power_off():
    """Detach all servos (stops PWM signal — servos go limp)."""
    for leg in range(1, 7):
        kit, _ = _get_kit_and_channel(leg, 1)
    for kit in (_kit_a, _kit_b):
        for ch in range(9):
            kit.servo[ch].angle = None
    print("[servo_driver] Servos powered off.")
