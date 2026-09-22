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
PCA_ALL_OFF_H  = 0xFD

class DirectPCA9685:
    """Minimal, robust dual-PCA9685 driver with PWM phase staggering."""
    def __init__(self, bus_num=1, freq_hz=50, osc_hz=25000000):
        self.freq_hz = freq_hz
        self.osc_hz = osc_hz
        self.is_real = False
        self.smbus = None

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

        # Initialize both boards if on real hardware
        if self.is_real:
            for bname, binfo in BOARDS.items():
                addr = binfo["address"]
                try:
                    self._init_board(addr)
                    print(f"[OK] PCA9685 '{bname}' initialized at address 0x{addr:02X}")
                except Exception as ex:
                    print(f"[WARN] Could not initialize '{bname}' at 0x{addr:02X}: {ex}")

    def _init_board(self, addr):
        prescale = int(round(self.osc_hz / (4096.0 * self.freq_hz)) - 1)
        self.smbus.write_byte_data(addr, PCA_MODE1, 0x10)  # sleep
        time.sleep(0.005)
        self.smbus.write_byte_data(addr, PCA_PRESCALE, prescale)
        self.smbus.write_byte_data(addr, PCA_MODE1, 0x00)  # wake
        time.sleep(0.005)
        self.smbus.write_byte_data(addr, PCA_MODE1, 0xA1)  # restart + auto-inc
        self.smbus.write_byte_data(addr, PCA_MODE2, 0x04)  # totem pole

    def set_pulse_us(self, board_name, channel, pulse_us):
        """Sets servo pulse in microseconds using phase staggering."""
        addr = BOARDS[board_name]["address"]
        period_us = 1000000.0 / self.freq_hz
        length_ticks = int(round((pulse_us / period_us) * 4096.0))
        length_ticks = max(0, min(4095, length_ticks))

        # Anti-jitter phase staggering: stagger rising edges by channel offset
        on_tick = (channel * 256) % 4096
        off_tick = (on_tick + length_ticks) % 4096

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
                except Exception:
                    time.sleep(0.002)

    def release_channel(self, board_name, channel):
        """Cuts power to a specific channel (0mA draw)."""
        addr = BOARDS[board_name]["address"]
        if self.is_real and self.smbus:
            reg = PCA_LED0_ON_L + 4 * channel
            try:
                # Bit 4 of OFF_H sets channel full OFF
                self.smbus.write_i2c_block_data(addr, reg, [0, 0, 0, 0x10])
            except Exception:
                pass

    def release_all(self):
        """Immediately turns off all channels on both boards."""
        if self.is_real and self.smbus:
            for binfo in BOARDS.values():
                try:
                    self.smbus.write_byte_data(binfo["address"], PCA_ALL_OFF_H, 0x10)
                except Exception:
                    pass
        print("\n[STOP] All servo channels released (power cut).")

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


def soft_ramp_to(servo_targets, duration_s=1.0, steps=40):
    """Smoothly moves servos from current/center to target positions."""
    drv = get_driver()
    dt = duration_s / float(steps)

    # We assume starting from center 1500us
    for step in range(steps + 1):
        alpha = step / float(steps)
        # Smooth cosine interpolation (S-curve)
        blend = 0.5 * (1.0 - math.cos(math.pi * alpha))

        for sid, target_us in servo_targets.items():
            sc = SERVOS[sid]
            clamped = max(sc["min"], min(sc["max"], target_us))
            current = 1500.0 + (clamped - 1500.0) * blend
            drv.set_pulse_us(sc["board"], sc["ch"], current)

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
        print(f"\n--> Testing Joint: {sid} ({sc['model']} on {sc['board']} board, ch {sc['ch']})")
        print(f"    Limits: MIN = {sc['min']}us  |  CENTER = {sc['center']}us  |  MAX = {sc['max']}us")

        # 1. Smooth to Center
        soft_ramp_to({sid: sc["center"]}, duration_s=0.6)
        time.sleep(0.4)

        # 2. Smooth to Min (safe margin)
        safe_min = sc["min"] + 40
        print(f"    Moving towards MIN: {safe_min}us...")
        soft_ramp_to({sid: safe_min}, duration_s=1.0)
        time.sleep(0.5)

        # 3. Smooth to Max (safe margin)
        safe_max = sc["max"] - 40
        print(f"    Moving towards MAX: {safe_max}us...")
        soft_ramp_to({sid: safe_max}, duration_s=1.5)
        time.sleep(0.5)

        # 4. Return to Center & Release
        print(f"    Returning to Center: {sc['center']}us...")
        soft_ramp_to({sid: sc["center"]}, duration_s=1.0)
        time.sleep(0.3)
        drv.release_channel(sc["board"], sc["ch"])

    print(f"\n[DONE] Range limit sweep for Leg {leg_name} complete.")


def test_leg_gait(leg_name, cycles=8):
    """
    Executes a realistic stepping/walking cycle trajectory on ONE LEG ONLY.
    Current draw: ~0.9A peak. All other 9 servos remain completely unpowered.
    """
    print(f"\n=======================================================")
    print(f"  WALKING GAIT CYCLE: Leg {leg_name}")
    print(f"  (Simulating Swing & Stance foot motion, ~0.9A draw)")
    print(f"=======================================================")
    drv = get_driver()
    joint_ids = LEGS[leg_name]
    coxa_id, femur_id, tibia_id = joint_ids

    sc_c = SERVOS[coxa_id]
    sc_f = SERVOS[femur_id]
    sc_t = SERVOS[tibia_id]

    # Ensure other legs unpowered
    for sid, sc in SERVOS.items():
        if sid not in joint_ids:
            drv.release_channel(sc["board"], sc["ch"])

    print("Soft-starting to nominal stand pose...")
    soft_ramp_to({coxa_id: 1500, femur_id: 1500, tibia_id: 1500}, duration_s=1.0)
    time.sleep(0.5)

    print(f"Running {cycles} walk step cycles on {leg_name}... Press Ctrl+C to stop.")

    # Stepping trajectory parameters (amplitudes in microseconds)
    # Stance: leg pushes back (femur/tibia on ground)
    # Swing: femur lifts, tibia folds, leg moves forward
    femur_lift_amp = 180.0   # Lift knee
    tibia_fold_amp = 150.0   # Flex foot
    coxa_swing_amp = 140.0   # Swing forward/back

    rate_hz = 50.0
    dt = 1.0 / rate_hz
    cycle_period_s = 1.6
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
            # Move coxa from rear (-1) to front (+1)
            coxa_progress = math.cos(math.pi * swing_progress)
            coxa_pulse = 1500.0 - coxa_swing_amp * coxa_progress
        else:
            # --- STANCE PHASE (60% of cycle: foot is on the ground pushing backward) ---
            stance_progress = (phase - 0.4) / 0.6  # 0.0 to 1.0
            femur_pulse = 1500.0
            tibia_pulse = 1500.0
            # Move coxa from front (+1) to rear (-1)
            coxa_pulse = 1500.0 + coxa_swing_amp * (1.0 - 2.0 * stance_progress)

        # Clamp to calibrated safety limits from Excel sheet
        c_p = max(sc_c["min"], min(sc_c["max"], coxa_pulse))
        f_p = max(sc_f["min"], min(sc_f["max"], femur_pulse))
        t_p = max(sc_t["min"], min(sc_t["max"], tibia_pulse))

        drv.set_pulse_us(sc_c["board"], sc_c["ch"], c_p)
        drv.set_pulse_us(sc_f["board"], sc_f["ch"], f_p)
        drv.set_pulse_us(sc_t["board"], sc_t["ch"], t_p)

        if i % 25 == 0:
            pct = int((i / total_steps) * 100)
            sys.stdout.write(f"\r  Progress: {pct}% | Coxa: {int(c_p)}us | Femur: {int(f_p)}us | Tibia: {int(t_p)}us   ")
            sys.stdout.flush()

        time.sleep(dt)

    print(f"\nReturning {leg_name} to neutral and releasing...")
    soft_ramp_to({coxa_id: 1500, femur_id: 1500, tibia_id: 1500}, duration_s=0.8)
    time.sleep(0.3)
    for sid in joint_ids:
        drv.release_channel(SERVOS[sid]["board"], SERVOS[sid]["ch"])
    print(f"[DONE] Walking gait cycle on Leg {leg_name} finished successfully.")


def test_single_joint(joint_id):
    """Jogs a single joint gently (±150us) to check direction and response."""
    if joint_id not in SERVOS:
        print(f"[ERROR] Unknown joint '{joint_id}'. Valid choices: {list(SERVOS.keys())}")
        return

    sc = SERVOS[joint_id]
    drv = get_driver()
    print(f"\n--> JOG TEST: {joint_id} ({sc['model']} on {sc['board']} board, ch {sc['ch']})")
    print(f"    Safe Pulse Range: {sc['min']}us - {sc['max']}us (Center: {sc['center']}us)")

    # Release everything else
    drv.release_all()
    time.sleep(0.1)

    print("Centering servo to 1500us...")
    soft_ramp_to({joint_id: 1500}, duration_s=0.6)
    time.sleep(0.5)

    print("Jogging +150us (CW)...")
    soft_ramp_to({joint_id: 1650}, duration_s=0.6)
    time.sleep(0.5)

    print("Jogging -150us (CCW)...")
    soft_ramp_to({joint_id: 1350}, duration_s=0.8)
    time.sleep(0.5)

    print("Returning to 1500us Center...")
    soft_ramp_to({joint_id: 1500}, duration_s=0.6)
    time.sleep(0.3)

    print("Releasing power...")
    drv.release_channel(sc["board"], sc["ch"])
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
    drv = get_driver()
    while True:
        bat_str = "N/A"
        if drv.is_real and drv.smbus:
            b_info = read_battery(drv.smbus)
            if b_info:
                bat_str = f"{b_info[0]:.2f}V ({int(b_info[1])}%) [{b_info[2]}]"

        print("\n" + "=" * 60)
        print("     QUADBOT DIRECT LEG TESTER (Servo Calibration v2)")
        print(f"     Battery: {bat_str}")
        print("=" * 60)
        print("  [1] Test Front-Left  Leg (FL) -> Walking Cycle (~0.9A)")
        print("  [2] Test Front-Right Leg (FR) -> Walking Cycle (~0.9A)")
        print("  [3] Test Rear-Left   Leg (RL) -> Walking Cycle (~0.9A)")
        print("  [4] Test Rear-Right  Leg (RR) -> Walking Cycle (~0.9A)")
        print("  [5] Test All 4 Legs Sequentially (One by One)")
        print("  ----------------------------------------------------")
        print("  [6] Center Pose on a Leg (1500us Neutral)")
        print("  [7] Range Limit Sweep on a Leg (MIN -> MAX from Excel)")
        print("  [8] Test a Single Joint (Jog ±150us)")
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
            jid = input("Enter joint name [FL_femur]: ").strip() or "FL_femur"
            test_single_joint(jid)
        elif choice == "b":
            if drv.is_real and drv.smbus:
                b = read_battery(drv.smbus)
                if b:
                    print(f"\n[BATTERY] 2S Pack: {b[0]:.2f}V ({int(b[1])}%) - Status: {b[2]}")
                else:
                    print("\n[BATTERY] ADS1115 at 0x48 not responding or no battery connected.")
            else:
                print("\n[BATTERY] Simulation mode: 2S Pack ~8.12V (86%) - Status: OK")
            input("Press Enter to continue...")
        elif choice == "9":
            drv.release_all()
        elif choice == "0":
            break
        else:
            print("Invalid choice, please enter 0-9 or b.")

    drv.release_all()
    print("Exiting leg tester. Bye!")


# ==============================================================================
# MAIN ENTRYPOINT
# ==============================================================================

def main():
    parser = argparse.ArgumentParser(description="Direct Raspberry Pi Leg Tester for Quadbot")
    parser.add_argument("--leg", choices=["FL", "FR", "RL", "RR"], help="Test a specific leg")
    parser.add_argument("--mode", choices=["gait", "sweep", "center"], default="gait",
                        help="Mode for leg test: 'gait' (walking cycle), 'sweep' (min->max), 'center' (1500us)")
    parser.add_argument("--joint", help="Test a single joint (e.g. FL_femur, FR_coxa)")
    parser.add_argument("--all-seq", action="store_true", help="Test all 4 legs sequentially (one leg at a time)")
    parser.add_argument("--battery", action="store_true", help="Read 2S battery voltage via ADS1115")
    parser.add_argument("--release", action="store_true", help="Release all servo channels immediately")

    args = parser.parse_args()

    drv = get_driver()

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

    # If no flags passed, launch the interactive menu
    interactive_menu()


if __name__ == "__main__":
    main()
