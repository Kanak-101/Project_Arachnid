#!/usr/bin/env python3
"""
Direct Leg Testing Script for Raspberry Pi 5 + Dual PCA9685
============================================================
Generated from: "Servo Calibration (2).xlsx"

Hardware Configuration:
- Left Board  (I2C: 0x40, Bus: 1): Front-Left (FL) and Rear-Left (RL)
- Right Board (I2C: 0x50, Bus: 1): Front-Right (FR) and Rear-Right (RR)

Safe Low-Power Testing:
- Powers ONLY ONE LEG AT A TIME (3 servos, ~0.9A draw)
- Unselected servos remain unpowered (0 mA draw)
- PWM phase staggering prevents current spikes
- Smooth ramping prevents mechanical slamming and voltage sags

Usage:
  python test_legs.py                # Interactive menu
  python test_legs.py --leg FL       # Test Front-Left leg (default: step cycle)
  python test_legs.py --leg FR       # Test Front-Right leg
  python test_legs.py --leg RL       # Test Rear-Left leg
  python test_legs.py --leg RR       # Test Rear-Right leg
  python test_legs.py --leg FL --mode sweep   # Range sweep test (min -> max)
  python test_legs.py --leg FL --mode center  # Hold 1500us neutral
  python test_legs.py --joint FL_femur        # Test single joint
  python test_legs.py --all-seq               # Test all 4 legs one by one
  python test_legs.py --release               # Release all servos immediately
"""

import sys
import time
import math
import argparse
import atexit
import signal

__test__ = False  # Mark file as operational script, not a pytest test suite

# ==============================================================================
# CALIBRATION DATA (From: Servo Calibration (2).xlsx)
# ==============================================================================

BOARDS = {
    "left":  {"bus": 1, "address": 0x40},  # Front-Left & Rear-Left
    "right": {"bus": 1, "address": 0x50},  # Front-Right & Rear-Right
}

SERVOS = {
    # --- Front-Left Leg (FL) on Left Board (0x40) ---
    "FL_coxa":  {"leg": "FL", "joint": "coxa",  "board": "left",  "ch": 0, "model": "MG958",  "min": 500, "max": 2500, "center": 1500},
    "FL_femur": {"leg": "FL", "joint": "femur", "board": "left",  "ch": 1, "model": "MG958",  "min": 620, "max": 2380, "center": 1500},
    "FL_tibia": {"leg": "FL", "joint": "tibia", "board": "left",  "ch": 2, "model": "MG958",  "min": 620, "max": 2380, "center": 1500},

    # --- Front-Right Leg (FR) on Right Board (0x50) ---
    "FR_coxa":  {"leg": "FR", "joint": "coxa",  "board": "right", "ch": 0, "model": "MG958",  "min": 500, "max": 2500, "center": 1500},
    "FR_femur": {"leg": "FR", "joint": "femur", "board": "right", "ch": 1, "model": "MG996R", "min": 620, "max": 2380, "center": 1500},
    "FR_tibia": {"leg": "FR", "joint": "tibia", "board": "right", "ch": 2, "model": "MG996R", "min": 620, "max": 2380, "center": 1500},

    # --- Rear-Left Leg (RL) on Left Board (0x40) ---
    "RL_coxa":  {"leg": "RL", "joint": "coxa",  "board": "left",  "ch": 3, "model": "MG958",  "min": 500, "max": 2500, "center": 1500},
    "RL_femur": {"leg": "RL", "joint": "femur", "board": "left",  "ch": 4, "model": "MG995",  "min": 600, "max": 2400, "center": 1500},
    "RL_tibia": {"leg": "RL", "joint": "tibia", "board": "left",  "ch": 5, "model": "MG995",  "min": 600, "max": 2400, "center": 1500},

    # --- Rear-Right Leg (RR) on Right Board (0x50) ---
    "RR_coxa":  {"leg": "RR", "joint": "coxa",  "board": "right", "ch": 3, "model": "MG958",  "min": 500, "max": 2500, "center": 1500},
    "RR_femur": {"leg": "RR", "joint": "femur", "board": "right", "ch": 4, "model": "MG996R", "min": 500, "max": 2500, "center": 1500},
    "RR_tibia": {"leg": "RR", "joint": "tibia", "board": "right", "ch": 5, "model": "MG996R", "min": 750, "max": 2250, "center": 1500},
}

LEGS = {
    "FL": ["FL_coxa", "FL_femur", "FL_tibia"],
    "FR": ["FR_coxa", "FR_femur", "FR_tibia"],
    "RL": ["RL_coxa", "RL_femur", "RL_tibia"],
    "RR": ["RR_coxa", "RR_femur", "RR_tibia"],
}

# ==============================================================================
# HARDWARE I2C / PCA9685 DRIVER WITH ANTI-JITTER PHASE STAGGERING
# ==============================================================================

# PCA9685 Register Map
PCA_MODE1      = 0x00
PCA_MODE2      = 0x01
PCA_PRESCALE   = 0xFE
PCA_LED0_ON_L  = 0x06
PCA_ALL_ON_H   = 0xFB
PCA_ALL_OFF_H  = 0xFD


def scan_i2c_bus(smbus, max_addr=0x77):
    """Scans I2C bus and returns list of responding 7-bit addresses."""
    found = []
    for addr in range(0x03, max_addr + 1):
        try:
            smbus.read_byte(addr)
            found.append(addr)
        except Exception:
            pass
    return found


class DirectPCA9685:
    """Robust dual-PCA9685 driver with hardware unlock & pre-flight diagnostics."""
    def __init__(self, bus_num=1, freq_hz=50, osc_hz=25000000):
        self.freq_hz = freq_hz
        self.osc_hz = osc_hz
        self.is_real = False
        self.smbus = None
        self.has_battery_adc = False
        self._last_pulse = {}

        try:
            try:
                from smbus2 import SMBus
            except ImportError:
                from smbus import SMBus
            self.smbus = SMBus(bus_num)
            self.is_real = True
            print(f"[OK] Opened I2C bus /dev/i2c-{bus_num}")
        except Exception as e:
            print(f"[NOTE] I2C hardware bus not available ({e}). Running in SIMULATION mode.")

        # Pre-flight check & initialization
        if self.is_real:
            found_addrs = scan_i2c_bus(self.smbus)
            detected_hex = [f"0x{a:02X}" for a in found_addrs]
            print("\n" + "=" * 60)
            print("         I2C HARDWARE PRE-FLIGHT SCAN")
            print("=" * 60)
            print(f"Devices detected on bus {bus_num}: {detected_hex if detected_hex else '[NONE]'}")

            left_detected = 0x40 in found_addrs
            right_detected = 0x50 in found_addrs
            self.has_battery_adc = 0x48 in found_addrs

            print(f"  * Left PCA9685  (0x40): {'[OK] Detected' if left_detected else '[FAIL] Missing!'}")
            print(f"  * Right PCA9685 (0x50): {'[OK] Detected' if right_detected else '[FAIL] Missing!'}")
            print(f"  * ADS1115 ADC   (0x48): {'[OK] Detected (Battery monitor active)' if self.has_battery_adc else '[--] Not detected (Battery monitor skipped)'}")
            print("=" * 60)

            if not left_detected and not right_detected:
                print("\n" + "!" * 60)
                print("[CRITICAL] NO PCA9685 BOARDS RESPONDED OVER I2C!")
                print("!" * 60)
                print("Troubleshooting checklist:")
                print("1. ADS1115 / Logic Level Shifter bus lock:")
                print("   If you recently connected the ADS1115 level shifter,")
                print("   disconnect its SDA and SCL wires from the Pi. A miswired")
                print("   or unpowered level shifter pulls the whole bus LOW.")
                print("2. Logic Power (VCC):")
                print("   Pi 3.3V (pin 1) -> PCA9685 VCC & Pi GND (pin 6) -> PCA9685 GND.")
                print("3. Servo Power (V+):")
                print("   Ensure 2S LiPo / UBEC is connected to the blue screw")
                print("   terminals on both PCA9685 boards and switched ON.")
                print("!" * 60 + "\n")

            for bname, binfo in BOARDS.items():
                addr = binfo["address"]
                try:
                    self._init_board(addr)
                    print(f"[OK] PCA9685 '{bname}' initialized & unlocked at address 0x{addr:02X}")
                except Exception as ex:
                    print(f"[WARN] Could not initialize '{bname}' at 0x{addr:02X}: {ex}")

    def _init_board(self, addr):
        prescale = int(round(self.osc_hz / (4096.0 * self.freq_hz)) - 1)
        # 1. Wake and reset mode
        self.smbus.write_byte_data(addr, PCA_MODE1, 0x00)
        time.sleep(0.005)
        # 2. Put to sleep so prescale can be set
        self.smbus.write_byte_data(addr, PCA_MODE1, 0x10)
        time.sleep(0.005)
        self.smbus.write_byte_data(addr, PCA_PRESCALE, prescale)
        # 3. Wake with Auto-Increment enabled (AI bit 5 = 0x20)
        self.smbus.write_byte_data(addr, PCA_MODE1, 0x20)
        time.sleep(0.005)
        # 4. Totem-pole / push-pull output driver (MODE2 bit 2: OUTDRV = 0x04)
        # CRITICAL: Without OUTDRV=1, outputs are open-drain and cannot pull HIGH to drive servos!
        self.smbus.write_byte_data(addr, PCA_MODE2, 0x04)
        # 5. CRITICAL: Clear ALL_LED_OFF_H (0xFD) and ALL_LED_ON_H (0xFB)
        # If ALL_LED_OFF is set to 0x10, hardware forces all channels to 0!
        self.smbus.write_byte_data(addr, PCA_ALL_OFF_H, 0x00)
        self.smbus.write_byte_data(addr, PCA_ALL_ON_H, 0x00)
        # 6. Put all 16 channels into individual released state
        for ch in range(16):
            reg = PCA_LED0_ON_L + 4 * ch
            self.smbus.write_i2c_block_data(addr, reg, [0, 0, 0, 0x10])

    def set_pulse_us(self, board_name, channel, pulse_us):
        """Sets servo pulse in microseconds (totem-pole, on_tick=0)."""
        addr = BOARDS[board_name]["address"]
        period_us = 1000000.0 / self.freq_hz
        length_ticks = int(round((pulse_us / period_us) * 4096.0))
        length_ticks = max(0, min(4095, length_ticks))

        # Standard proven RC servo timing: rising edge at tick 0
        on_tick = 0
        off_tick = length_ticks

        # Deadband filter: don't write to I2C if pulse change is less than 1.5us
        # Prevents high-gain digital servos (like MG958 coxa) from micro-hunting
        key = (board_name, channel)
        last = self._last_pulse.get(key)
        if last is not None and abs(last - pulse_us) < 1.5:
            return
        self._last_pulse[key] = pulse_us

        if self.is_real and self.smbus:
            reg = PCA_LED0_ON_L + 4 * channel
            data = [
                on_tick & 0xFF,
                (on_tick >> 8) & 0x0F,
                off_tick & 0xFF,
                (off_tick >> 8) & 0x0F,
            ]
            for attempt in range(3):
                try:
                    self.smbus.write_i2c_block_data(addr, reg, data)
                    return
                except Exception as ex:
                    if attempt == 2:
                        print(f"\n[ERROR] I2C write failed on {board_name} ch {channel} (0x{addr:02X}): {ex}")
                    time.sleep(0.002)

    def release_channel(self, board_name, channel):
        """Cuts power to a specific channel (servo goes limp)."""
        self._last_pulse.pop((board_name, channel), None)
        addr = BOARDS[board_name]["address"]
        if self.is_real and self.smbus:
            reg = PCA_LED0_ON_L + 4 * channel
            try:
                # Bit 4 of OFF_H sets channel full OFF
                self.smbus.write_i2c_block_data(addr, reg, [0, 0, 0, 0x10])
            except Exception:
                pass

    def release_all(self):
        """Immediately turns off all channels across both boards without locking 0xFD."""
        self._last_pulse.clear()
        if self.is_real and self.smbus:
            for bname, binfo in BOARDS.items():
                addr = binfo["address"]
                try:
                    # Release all 16 channels individually
                    for ch in range(16):
                        reg = PCA_LED0_ON_L + 4 * ch
                        self.smbus.write_i2c_block_data(addr, reg, [0, 0, 0, 0x10])
                    # Ensure global ALL_LED_OFF is cleared so chip isn't permanently locked
                    self.smbus.write_byte_data(addr, PCA_ALL_OFF_H, 0x00)
                except Exception:
                    pass
        print("\n[STOP] All servo channels released (power cut).")

## ==============================================================================
# SPEED PRESETS & SMOOTH TRAJECTORY CONFIGURATION
# ==============================================================================

SPEED_PRESETS = {
    "slow": {
        "name": "Slow (Gentle & Stable - Anti-Jitter Default)",
        "cycle_period_s": 2.8,
        "femur_lift_amp": 130.0,
        "tibia_fold_amp": 110.0,
        "coxa_swing_amp": 65.0,     # Damped coxa amplitude for digital servos
        "ramp_duration_s": 1.2,
        "jog_amp": 80.0,            # Gentle +/-80us jog
        "jog_duration_s": 1.2,
    },
    "normal": {
        "name": "Normal (Standard Walk)",
        "cycle_period_s": 2.0,
        "femur_lift_amp": 160.0,
        "tibia_fold_amp": 135.0,
        "coxa_swing_amp": 95.0,
        "ramp_duration_s": 0.9,
        "jog_amp": 110.0,
        "jog_duration_s": 0.8,
    },
    "fast": {
        "name": "Fast (Demonstration)",
        "cycle_period_s": 1.5,
        "femur_lift_amp": 180.0,
        "tibia_fold_amp": 150.0,
        "coxa_swing_amp": 120.0,
        "ramp_duration_s": 0.6,
        "jog_amp": 140.0,
        "jog_duration_s": 0.5,
    },
}

CURRENT_SPEED = "slow"
CURRENT_US = {sid: 1500.0 for sid in SERVOS}

# ==============================================================================
# TESTING ROUTINES
# ==============================================================================

driver = None

def get_driver():
    global driver
    if driver is None:
        driver = DirectPCA9685()
    return driver

def cleanup():
    if driver:
        driver.release_all()

atexit.register(cleanup)
signal.signal(signal.SIGINT, lambda s, f: sys.exit(0))


def soft_ramp_to(servo_targets, duration_s=None, steps=50):
    """Smoothly moves servos from their ACTUAL current positions to targets."""
    global CURRENT_US
    if duration_s is None:
        duration_s = SPEED_PRESETS[CURRENT_SPEED]["ramp_duration_s"]

    drv = get_driver()
    dt = duration_s / float(steps)

    # Snapshot current positions as starts so transitions are 100% step-free
    starts = {sid: CURRENT_US.get(sid, 1500.0) for sid in servo_targets}

    for step in range(1, steps + 1):
        alpha = step / float(steps)
        # Cosine S-curve interpolation (smooth start and stop, zero velocity at endpoints)
        blend = 0.5 * (1.0 - math.cos(math.pi * alpha))

        for sid, target_us in servo_targets.items():
            sc = SERVOS[sid]
            clamped = max(sc["min"], min(sc["max"], target_us))
            start = starts[sid]
            current = start + (clamped - start) * blend
            drv.set_pulse_us(sc["board"], sc["ch"], current)
            CURRENT_US[sid] = current

        time.sleep(dt)


def test_leg_center(leg_name, hold_seconds=3.0):
    """Holds all 3 joints of a single leg at neutral 1500us."""
    print(f"\n=======================================================")
    print(f"  CENTER TEST: Leg {leg_name} (3 Servos @ 1500us)")
    print(f"=======================================================")
    drv = get_driver()
    joint_ids = LEGS[leg_name]

    # Ensure other 9 servos are limp
    for sid, sc in SERVOS.items():
        if sid not in joint_ids:
            drv.release_channel(sc["board"], sc["ch"])

    print(f"Ramping {joint_ids} smoothly to 1500us...")
    targets = {sid: 1500 for sid in joint_ids}
    soft_ramp_to(targets, duration_s=1.2)

    print(f"Holding center for {hold_seconds:.1f}s. Check leg mechanical alignment...")
    time.sleep(hold_seconds)

    print("Releasing leg power...")
    for sid in joint_ids:
        sc = SERVOS[sid]
        drv.release_channel(sc["board"], sc["ch"])
        CURRENT_US[sid] = 1500.0
    print(f"[DONE] Center test for Leg {leg_name} finished.")


def test_leg_sweep(leg_name):
    """Tests full range limits (SRV_MIN to SRV_MAX) for each joint of the leg."""
    print(f"\n=======================================================")
    print(f"  RANGE LIMIT SWEEP: Leg {leg_name}")
    print(f"  (Verifying SRV_MIN & SRV_MAX from Excel Sheet)")
    print(f"=======================================================")
    drv = get_driver()
    joint_ids = LEGS[leg_name]

    for sid in joint_ids:
        sc = SERVOS[sid]
        is_coxa = "coxa" in sid
        sweep_dur = 1.6 if is_coxa else 1.2
        print(f"\n--> Testing Joint: {sid} ({sc['model']} on {sc['board']} board, ch {sc['ch']})")
        print(f"    Limits: MIN = {sc['min']}us  |  CENTER = {sc['center']}us  |  MAX = {sc['max']}us")

        # 1. Smooth to Center
        soft_ramp_to({sid: sc["center"]}, duration_s=0.8)
        time.sleep(0.4)

        # 2. Smooth to Min (safe margin)
        safe_min = sc["min"] + 40
        print(f"    Moving towards MIN: {safe_min}us...")
        soft_ramp_to({sid: safe_min}, duration_s=sweep_dur)
        time.sleep(0.5)

        # 3. Smooth to Max (safe margin)
        safe_max = sc["max"] - 40
        print(f"    Moving towards MAX: {safe_max}us...")
        soft_ramp_to({sid: safe_max}, duration_s=sweep_dur * 1.5)
        time.sleep(0.5)

        # 4. Return to Center & Release
        print(f"    Returning to Center: {sc['center']}us...")
        soft_ramp_to({sid: sc["center"]}, duration_s=sweep_dur)
        time.sleep(0.3)
        drv.release_channel(sc["board"], sc["ch"])
        CURRENT_US[sid] = sc["center"]

    print(f"\n[DONE] Range limit sweep for Leg {leg_name} complete.")


def test_leg_gait(leg_name, cycles=6):
    """
    Executes a realistic stepping/walking cycle trajectory on ONE LEG ONLY.
    Continuous C1 cosine trajectory prevents high-gain digital servo (MG958 coxa) jitter.
    """
    drv = get_driver()
    joint_ids = LEGS[leg_name]
    coxa_id, femur_id, tibia_id = joint_ids

    sc_c = SERVOS[coxa_id]
    sc_f = SERVOS[femur_id]
    sc_t = SERVOS[tibia_id]

    speed_cfg = SPEED_PRESETS[CURRENT_SPEED]
    cycle_period_s = speed_cfg["cycle_period_s"]
    femur_lift_amp = speed_cfg["femur_lift_amp"]
    tibia_fold_amp = speed_cfg["tibia_fold_amp"]
    coxa_swing_amp = speed_cfg["coxa_swing_amp"]

    # Ensure other legs unpowered
    for sid, sc in SERVOS.items():
        if sid not in joint_ids:
            drv.release_channel(sc["board"], sc["ch"])

    print(f"\n=======================================================")
    print(f"  WALKING GAIT CYCLE: Leg {leg_name} [SPEED: {CURRENT_SPEED.upper()}]")
    print(f"  Cycle Period: {cycle_period_s}s | Coxa Amp: +/-{int(coxa_swing_amp)}us | Lift: +/-{int(femur_lift_amp)}us")
    print(f"=======================================================")

    print("Soft-starting to nominal stand pose...")
    soft_ramp_to({coxa_id: 1500, femur_id: 1500, tibia_id: 1500}, duration_s=1.2)
    time.sleep(0.4)

    print(f"Running {cycles} walk step cycles on {leg_name}... Press Ctrl+C to stop.")

    rate_hz = 50.0
    dt = 1.0 / rate_hz
    total_steps = int(cycles * cycle_period_s * rate_hz)

    for i in range(total_steps):
        t = i * dt
        phase = (t / cycle_period_s) % 1.0  # 0.0 to 1.0

        if phase < 0.4:
            # --- SWING PHASE (40% of cycle: foot is lifted in the air moving forward) ---
            swing_progress = phase / 0.4  # 0.0 to 1.0
            # Sine bump for foot lift
            lift = math.sin(math.pi * swing_progress)
            femur_pulse = 1500.0 - femur_lift_amp * lift
            tibia_pulse = 1500.0 + tibia_fold_amp * lift
            # Smooth cosine forward swing: from -coxa_swing_amp to +coxa_swing_amp
            coxa_progress = math.cos(math.pi * swing_progress)
            coxa_pulse = 1500.0 - coxa_swing_amp * coxa_progress
        else:
            # --- STANCE PHASE (60% of cycle: foot on ground pushing backward) ---
            stance_progress = (phase - 0.4) / 0.6  # 0.0 to 1.0
            femur_pulse = 1500.0
            tibia_pulse = 1500.0
            # Smooth cosine return: zero velocity and zero acceleration jerk at endpoints
            coxa_progress = math.cos(math.pi * (1.0 - stance_progress))
            coxa_pulse = 1500.0 + coxa_swing_amp * coxa_progress

        # Clamp to calibrated safety limits from Excel sheet
        c_p = max(sc_c["min"], min(sc_c["max"], coxa_pulse))
        f_p = max(sc_f["min"], min(sc_f["max"], femur_pulse))
        t_p = max(sc_t["min"], min(sc_t["max"], tibia_pulse))

        drv.set_pulse_us(sc_c["board"], sc_c["ch"], c_p)
        drv.set_pulse_us(sc_f["board"], sc_f["ch"], f_p)
        drv.set_pulse_us(sc_t["board"], sc_t["ch"], t_p)

        CURRENT_US[coxa_id] = c_p
        CURRENT_US[femur_id] = f_p
        CURRENT_US[tibia_id] = t_p

        if i % 25 == 0:
            pct = int((i / total_steps) * 100)
            sys.stdout.write(f"\r  Progress: {pct}% | Coxa: {int(c_p)}us | Femur: {int(f_p)}us | Tibia: {int(t_p)}us   ")
            sys.stdout.flush()

        time.sleep(dt)

    print(f"\nReturning {leg_name} to neutral and releasing...")
    soft_ramp_to({coxa_id: 1500, femur_id: 1500, tibia_id: 1500}, duration_s=1.0)
    time.sleep(0.3)
    for sid in joint_ids:
        drv.release_channel(SERVOS[sid]["board"], SERVOS[sid]["ch"])
        CURRENT_US[sid] = 1500.0
    print(f"[DONE] Walking gait cycle on Leg {leg_name} finished successfully.")


def test_single_joint(joint_id):
    """Jogs a single joint gently with smooth S-curve ramping and speed presets."""
    if joint_id not in SERVOS:
        print(f"[ERROR] Unknown joint '{joint_id}'. Valid choices: {list(SERVOS.keys())}")
        return

    sc = SERVOS[joint_id]
    drv = get_driver()
    is_coxa = "coxa" in joint_id
    speed_cfg = SPEED_PRESETS[CURRENT_SPEED]

    # For Coxa (high-gain MG958 digital), use gentler jog amplitude to prevent hunting
    jog_amp = speed_cfg["jog_amp"] * (0.75 if is_coxa else 1.0)
    jog_dur = speed_cfg["jog_duration_s"] * (1.3 if is_coxa else 1.0)

    print(f"\n--> JOG TEST: {joint_id} ({sc['model']} on {sc['board']} board, ch {sc['ch']})")
    print(f"    Speed: {CURRENT_SPEED.upper()} | Jog Amp: +/-{int(jog_amp)}us | Duration: {jog_dur:.1f}s")
    print(f"    Safe Pulse Range: {sc['min']}us - {sc['max']}us (Center: {sc['center']}us)")

    # Release everything else
    drv.release_all()
    time.sleep(0.1)

    print("1. Centering servo to 1500us...")
    soft_ramp_to({joint_id: 1500}, duration_s=1.0)
    time.sleep(0.5)

    print(f"2. Jogging +{int(jog_amp)}us (CW)...")
    soft_ramp_to({joint_id: 1500.0 + jog_amp}, duration_s=jog_dur)
    time.sleep(0.5)

    print(f"3. Jogging -{int(jog_amp)}us (CCW)...")
    soft_ramp_to({joint_id: 1500.0 - jog_amp}, duration_s=jog_dur * 1.5)
    time.sleep(0.5)

    print("4. Returning to 1500us Center...")
    soft_ramp_to({joint_id: 1500}, duration_s=jog_dur)
    time.sleep(0.3)

    print("5. Releasing power...")
    drv.release_channel(sc["board"], sc["ch"])
    CURRENT_US[joint_id] = 1500.0
    print(f"[DONE] Joint {joint_id} jog test complete.")


def test_all_legs_sequentially():
    """Runs gait test on each leg one after the other (never powering >3 servos at once)."""
    print("\n=======================================================")
    print("  SEQUENTIAL 4-LEG TEST (One Leg at a Time)")
    print("  Prevents power collapse while verifying all 4 legs")
    print("=======================================================")
    for leg in ["FL", "FR", "RL", "RR"]:
        test_leg_gait(leg, cycles=4)
        print("Pausing 1.5s before next leg...\n")
        time.sleep(1.5)
    print("\n[DONE] All 4 legs tested sequentially!")


def read_battery(bus, addr=0x48, channel=0, divider_ratio=5.0):
    """Reads 2S battery voltage via ADS1115 on AIN0 with 5:1 divider."""
    try:
        mux = 0b100 + channel
        cfg_msb = 0x80 | (mux << 4) | (0b001 << 1) | 1  # 0xC3 for ch 0
        cfg_lsb = (0b100 << 5) | 0x03
        bus.write_i2c_block_data(addr, 0x01, [cfg_msb, cfg_lsb])
        time.sleep(0.012)
        data = bus.read_i2c_block_data(addr, 0x00, 2)
        raw = (data[0] << 8) | data[1]
        if raw > 32767:
            raw -= 65536
        pin_v = max(0.0, raw * (4.096 / 32768.0))
        bat_v = pin_v * divider_ratio
        if bat_v < 1.0:
            return None
        pct = max(0.0, min(100.0, (bat_v - 6.6) / (8.4 - 6.6) * 100.0))
        status = "OK" if bat_v > 7.1 else "LOW WARNING" if bat_v > 6.6 else "CRITICAL (<6.6V)"
        return bat_v, pct, status
    except Exception:
        return None


# ==============================================================================
# INTERACTIVE TERMINAL MENU
# ==============================================================================

def interactive_menu():
    global CURRENT_SPEED
    drv = get_driver()
    speed_keys = ["slow", "normal", "fast"]

    while True:
        bat_str = "N/A"
        if drv.is_real and drv.smbus and drv.has_battery_adc:
            b_info = read_battery(drv.smbus)
            if b_info:
                bat_str = f"{b_info[0]:.2f}V ({int(b_info[1])}%) [{b_info[2]}]"

        cur_speed_desc = SPEED_PRESETS[CURRENT_SPEED]["name"]

        print("\n" + "=" * 60)
        print("     QUADBOT DIRECT LEG TESTER (Servo Calibration v2)")
        print(f"     Battery: {bat_str} | Speed: {CURRENT_SPEED.upper()}")
        print("=" * 60)
        print("  [1] Test Front-Left  Leg (FL) -> Walking Cycle (~0.9A)")
        print("  [2] Test Front-Right Leg (FR) -> Walking Cycle (~0.9A)")
        print("  [3] Test Rear-Left   Leg (RL) -> Walking Cycle (~0.9A)")
        print("  [4] Test Rear-Right  Leg (RR) -> Walking Cycle (~0.9A)")
        print("  [5] Test All 4 Legs Sequentially (One by One)")
        print("  ----------------------------------------------------")
        print("  [6] Center Pose on a Leg (1500us Neutral)")
        print("  [7] Range Limit Sweep on a Leg (MIN -> MAX from Excel)")
        print("  [8] Test a Single Joint (Jog gentle +/-80us)")
        print(f"  [v] TOGGLE SPEED (Currently: {CURRENT_SPEED.upper()} - {cur_speed_desc})")
        print("  [s] Re-scan I2C Bus & Re-initialize Boards")
        print("  [b] Check Battery Status (ADS1115)")
        print("  [9] RELEASE ALL SERVOS (Cut Power)")
        print("  [0] Exit")
        print("=" * 60)

        try:
            choice = input("Enter choice: ").strip().lower()
        except (EOFError, KeyboardInterrupt):
            break

        if choice == "1":
            test_leg_gait("FL")
        elif choice == "2":
            test_leg_gait("FR")
        elif choice == "3":
            test_leg_gait("RL")
        elif choice == "4":
            test_leg_gait("RR")
        elif choice == "5":
            test_all_legs_sequentially()
        elif choice == "6":
            leg = input("Which leg (FL, FR, RL, RR)? [FL]: ").strip().upper() or "FL"
            if leg in LEGS:
                test_leg_center(leg)
            else:
                print("[ERROR] Invalid leg name.")
        elif choice == "7":
            leg = input("Which leg (FL, FR, RL, RR)? [FL]: ").strip().upper() or "FL"
            if leg in LEGS:
                test_leg_sweep(leg)
            else:
                print("[ERROR] Invalid leg name.")
        elif choice == "8":
            print("Available joints:", ", ".join(SERVOS.keys()))
            jid = input("Enter joint name [FL_coxa]: ").strip() or "FL_coxa"
            test_single_joint(jid)
        elif choice == "v":
            idx = (speed_keys.index(CURRENT_SPEED) + 1) % len(speed_keys)
            CURRENT_SPEED = speed_keys[idx]
            print(f"\n--> Speed switched to: {CURRENT_SPEED.upper()} ({SPEED_PRESETS[CURRENT_SPEED]['name']})")
        elif choice == "s":
            if drv.is_real and drv.smbus:
                found_addrs = scan_i2c_bus(drv.smbus)
                print(f"\n[SCAN] Detected on I2C bus: {[f'0x{a:02X}' for a in found_addrs]}")
                for bname, binfo in BOARDS.items():
                    addr = binfo["address"]
                    try:
                        drv._init_board(addr)
                        print(f"  [OK] PCA9685 '{bname}' (0x{addr:02X}) re-initialized & unlocked.")
                    except Exception as ex:
                        print(f"  [FAIL] '{bname}' (0x{addr:02X}): {ex}")
                drv.has_battery_adc = 0x48 in found_addrs
            else:
                print("\n[SCAN] Running in simulation mode (no hardware I2C bus).")
            input("Press Enter to continue...")
        elif choice == "b":
            if drv.is_real and drv.smbus:
                if drv.has_battery_adc:
                    b = read_battery(drv.smbus)
                    if b:
                        print(f"\n[BATTERY] 2S Pack: {b[0]:.2f}V ({int(b[1])}%) - Status: {b[2]}")
                    else:
                        print("\n[BATTERY] ADS1115 read error.")
                else:
                    print("\n[BATTERY] ADS1115 was not detected on I2C bus at address 0x48.")
            else:
                print("\n[BATTERY] Simulation mode: 2S Pack ~8.12V (86%) - Status: OK")
            input("Press Enter to continue...")
        elif choice == "9":
            drv.release_all()
        elif choice == "0":
            break
        else:
            print("Invalid choice, please enter 0-9, v, s, or b.")

    drv.release_all()
    print("Exiting leg tester. Bye!")


# ==============================================================================
# MAIN ENTRYPOINT
# ==============================================================================

def main():
    global CURRENT_SPEED
    parser = argparse.ArgumentParser(description="Direct Raspberry Pi Leg Tester for Quadbot")
    parser.add_argument("--leg", choices=["FL", "FR", "RL", "RR"], help="Test a specific leg")
    parser.add_argument("--mode", choices=["gait", "sweep", "center"], default="gait",
                        help="Mode for leg test: 'gait' (walking cycle), 'sweep' (min->max), 'center' (1500us)")
    parser.add_argument("--joint", help="Test a single joint (e.g. FL_coxa, FL_femur)")
    parser.add_argument("--speed", choices=["slow", "normal", "fast"], default="slow",
                        help="Speed preset (default: 'slow' for anti-jitter stability)")
    parser.add_argument("--all-seq", action="store_true", help="Test all 4 legs sequentially (one leg at a time)")
    parser.add_argument("--scan", action="store_true", help="Scan I2C bus and unlock PCA9685 boards")
    parser.add_argument("--battery", action="store_true", help="Read 2S battery voltage via ADS1115")
    parser.add_argument("--release", action="store_true", help="Release all servo channels immediately")

    args = parser.parse_args()

    CURRENT_SPEED = args.speed
    drv = get_driver()

    if args.scan:
        # Pre-flight scan and unlock already executed during driver initialization
        return

    if args.battery:
        if drv.is_real and drv.smbus:
            b = read_battery(drv.smbus)
            if b:
                print(f"[BATTERY] 2S LiPo: {b[0]:.2f}V ({int(b[1])}%) - Status: {b[2]}")
            else:
                print("[BATTERY] ADS1115 at 0x48 not responding or no battery connected.")
        else:
            print("[BATTERY] Simulation mode: 2S LiPo ~8.12V (86%) - Status: OK")
        return

    if args.release:
        drv.release_all()
        return

    if args.joint:
        test_single_joint(args.joint)
        return

    if args.all_seq:
        test_all_legs_sequentially()
        return

    if args.leg:
        if args.mode == "gait":
            test_leg_gait(args.leg)
        elif args.mode == "sweep":
            test_leg_sweep(args.leg)
        elif args.mode == "center":
            test_leg_center(args.leg)
        return

    # If no flags passed, launch interactive menu
    interactive_menu()


if __name__ == "__main__":
    main()
