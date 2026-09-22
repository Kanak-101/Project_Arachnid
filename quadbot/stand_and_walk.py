#!/usr/bin/env python3
"""
Power-Efficient Stand, Hold Still, & 2-Leg Trot Gait Walk Script
================================================================
Hardware Mapping:
- Left Board  (I2C: 0x50, Bus: 1): Front-Left (FL) and Rear-Left (RL)
- Right Board (I2C: 0x40, Bus: 1): Front-Right (FR) and Rear-Right (RR)
- Battery ADC (I2C: 0x48, Bus: 1): ADS1115 2S LiPo monitor (AIN0, 5:1 divider)

Locomotion Sequence:
1. Soft Stand-Up: Cosine S-curve gentle ramp from rest to nominal stance (prevents current inrush).
2. Hold Still: Holds stable stance for 2.5 seconds (confirms posture & balance).
3. 2-Legs-at-a-Time Forward Walk: Synchronized diagonal trot gait for 5.0 seconds
   - Pair A (FL + RR): swings forward while Pair B supports body in stance.
   - Pair B (FR + RL): swings forward while Pair A supports body in stance.
4. Power-Saving Shutdown: Eases back to center and immediately cuts PWM power (limp mode)
   dropping idle current draw to 0.00A.

Usage:
  python stand_and_walk.py                    # Standard 5-second walk with 2.5s hold
  python stand_and_walk.py --duration 7.0     # Walk for 7 seconds
  python stand_and_walk.py --hold 3.0         # Hold still for 3 seconds before walking
  python stand_and_walk.py --speed normal     # Use normal speed instead of slow
  python stand_and_walk.py --scan             # Scan I2C bus and unlock boards
  python stand_and_walk.py --battery          # Read 2S battery status
  python stand_and_walk.py --release          # Cut power to all servos immediately
"""

import sys
import time
import math
import argparse
import atexit
import signal

# ==============================================================================
# HARDWARE CONFIGURATION & CALIBRATED LIMITS
# ==============================================================================

BOARDS = {
    "left":  {"bus": 1, "address": 0x50},  # Front-Left & Rear-Left
    "right": {"bus": 1, "address": 0x40},  # Front-Right & Rear-Right
}

# Calibrated limits from Servo Calibration (2).xlsx
SERVOS = {
    # Left Board (0x50)
    "FL_coxa":  {"board": "left",  "ch": 0, "model": "MG958",  "min": 500, "max": 2500, "center": 1500},
    "FL_femur": {"board": "left",  "ch": 1, "model": "MG958",  "min": 620, "max": 2380, "center": 1500},
    "FL_tibia": {"board": "left",  "ch": 2, "model": "MG958",  "min": 620, "max": 2380, "center": 1500},

    "RL_coxa":  {"board": "left",  "ch": 3, "model": "MG958",  "min": 500, "max": 2500, "center": 1500},
    "RL_femur": {"board": "left",  "ch": 4, "model": "MG995",  "min": 600, "max": 2400, "center": 1500},
    "RL_tibia": {"board": "left",  "ch": 5, "model": "MG995",  "min": 600, "max": 2400, "center": 1500},

    # Right Board (0x40)
    "FR_coxa":  {"board": "right", "ch": 0, "model": "MG958",  "min": 500, "max": 2500, "center": 1500},
    "FR_femur": {"board": "right", "ch": 1, "model": "MG996R", "min": 620, "max": 2380, "center": 1500},
    "FR_tibia": {"board": "right", "ch": 2, "model": "MG996R", "min": 620, "max": 2380, "center": 1500},

    "RR_coxa":  {"board": "right", "ch": 3, "model": "MG958",  "min": 500, "max": 2500, "center": 1500},
    "RR_femur": {"board": "right", "ch": 4, "model": "MG996R", "min": 500, "max": 2500, "center": 1500},
    "RR_tibia": {"board": "right", "ch": 5, "model": "MG996R", "min": 750, "max": 2250, "center": 1500},
}

# Diagonal pairs for 2-leg locomotion (Trot Gait)
PAIR_A = ["FL", "RR"]  # Front-Left + Rear-Right
PAIR_B = ["FR", "RL"]  # Front-Right + Rear-Left

# Power-saving motion presets
SPEED_PRESETS = {
    "slow": {
        "name": "Slow & Power Efficient",
        "cycle_period_s": 1.5,      # Calm cadence prevents back-EMF & dynamic current spikes
        "coxa_swing_amp": 55.0,     # Damped coxa amplitude for digital servos (low inertia)
        "femur_lift_amp": 85.0,     # Ground clearance without high vertical work
        "tibia_fold_amp": 70.0,     # Smooth foot tuck
        "stand_ramp_s": 1.8,        # Smooth S-curve stand up
    },
    "normal": {
        "name": "Normal Dynamic Trot",
        "cycle_period_s": 1.2,
        "coxa_swing_amp": 75.0,
        "femur_lift_amp": 100.0,
        "tibia_fold_amp": 85.0,
        "stand_ramp_s": 1.4,
    }
}

PCA_MODE1     = 0x00
PCA_MODE2     = 0x01
PCA_PRESCALE  = 0xFE
PCA_LED0_ON_L = 0x06
PCA_ALL_ON_H  = 0xFB
PCA_ALL_OFF_H = 0xFD

# State tracking to guarantee zero-velocity starts
CURRENT_US = {sid: 1500.0 for sid in SERVOS}


# ==============================================================================
# HARDWARE DRIVER
# ==============================================================================

def scan_i2c_bus(smbus, max_addr=0x77):
    found = []
    for addr in range(0x03, max_addr + 1):
        try:
            smbus.write_quick(addr)
            found.append(addr)
        except Exception:
            try:
                smbus.read_byte(addr)
                found.append(addr)
            except Exception:
                pass
    return found


class DirectPCA9685:
    """Direct, low-overhead hardware driver for PCA9685 with deadband filtering."""

    def __init__(self, bus_num=1):
        self.bus_num = bus_num
        self.is_real = False
        self.smbus = None
        self.last_written_us = {}
        self.has_battery_adc = False

        try:
            from smbus2 import SMBus
            self.smbus = SMBus(bus_num)
            self.is_real = True
        except Exception as e:
            print(f"[NOTE] I2C hardware bus not available ({e}). Running in SIMULATION mode.")

        if self.is_real and self.smbus:
            found_addrs = scan_i2c_bus(self.smbus)
            detected_hex = [f"0x{a:02X}" for a in found_addrs]
            print("\n" + "=" * 60)
            print("         I2C HARDWARE PRE-FLIGHT SCAN")
            print("=" * 60)
            print(f"Devices detected on bus {bus_num}: {detected_hex if detected_hex else '[NONE]'}")

            left_detected = 0x50 in found_addrs
            right_detected = 0x40 in found_addrs
            self.has_battery_adc = 0x48 in found_addrs

            print(f"  * Left PCA9685  (0x50): {'[OK] Detected' if left_detected else '[FAIL] Missing! (Verify A4 solder jumper)'}")
            print(f"  * Right PCA9685 (0x40): {'[OK] Detected' if right_detected else '[FAIL] Missing!'}")
            print(f"  * Battery ADC   (0x48): {'[OK] Detected (Battery monitor active)' if self.has_battery_adc else '[--] Not detected (Battery monitor skipped)'}")
            print("=" * 60)

            for bname, bcfg in BOARDS.items():
                addr = bcfg["address"]
                try:
                    self._init_board(addr)
                    print(f"[OK] PCA9685 '{bname}' initialized & unlocked at address 0x{addr:02X}")
                except Exception as ex:
                    print(f"[WARN] Could not initialize '{bname}' at 0x{addr:02X}: {ex}")

    def _init_board(self, addr, freq_hz=50):
        prescale = int(round(25000000.0 / (4096.0 * freq_hz)) - 1)
        self.smbus.write_byte_data(addr, PCA_MODE1, 0x00)
        time.sleep(0.005)
        self.smbus.write_byte_data(addr, PCA_MODE1, 0x10)
        self.smbus.write_byte_data(addr, PCA_PRESCALE, prescale)
        self.smbus.write_byte_data(addr, PCA_MODE1, 0x20)  # Auto-Increment enable
        time.sleep(0.005)
        self.smbus.write_byte_data(addr, PCA_MODE2, 0x04)  # Totem-pole push-pull driver
        self.smbus.write_byte_data(addr, PCA_ALL_OFF_H, 0x00)  # Clear global override
        self.smbus.write_byte_data(addr, PCA_ALL_ON_H, 0x00)

        for ch in range(16):
            reg = PCA_LED0_ON_L + 4 * ch
            self.smbus.write_i2c_block_data(addr, reg, [0, 0, 0, 0x10])

    def set_pulse_us(self, board_name, channel, us):
        addr = BOARDS[board_name]["address"]
        prev = self.last_written_us.get((board_name, channel))
        # 1.5us deadband suppression for high-gain digital servos
        if prev is not None and abs(us - prev) < 1.5:
            return

        self.last_written_us[(board_name, channel)] = us

        if self.is_real and self.smbus:
            length_ticks = int(round(us * 4096.0 / 20000.0))
            length_ticks = max(0, min(4095, length_ticks))
            reg = PCA_LED0_ON_L + 4 * channel
            data = [
                0x00,
                0x00,
                length_ticks & 0xFF,
                (length_ticks >> 8) & 0x0F,
            ]
            try:
                self.smbus.write_i2c_block_data(addr, reg, data)
            except Exception as ex:
                print(f"\n[ERROR] I2C write failed on {board_name} ch {channel} (0x{addr:02X}): {ex}")

    def release_channel(self, board_name, channel):
        addr = BOARDS[board_name]["address"]
        self.last_written_us.pop((board_name, channel), None)
        if self.is_real and self.smbus:
            reg = PCA_LED0_ON_L + 4 * channel
            try:
                self.smbus.write_i2c_block_data(addr, reg, [0, 0, 0, 0x10])
            except Exception:
                pass

    def release_all(self):
        """Cuts power to all servos immediately across both boards."""
        self.last_written_us.clear()
        if self.is_real and self.smbus:
            for bcfg in BOARDS.values():
                addr = bcfg["address"]
                for ch in range(16):
                    reg = PCA_LED0_ON_L + 4 * ch
                    try:
                        self.smbus.write_i2c_block_data(addr, reg, [0, 0, 0, 0x10])
                    except Exception:
                        pass
                try:
                    self.smbus.write_byte_data(addr, PCA_ALL_OFF_H, 0x00)
                except Exception:
                    pass


_DRIVER = None

def get_driver():
    global _DRIVER
    if _DRIVER is None:
        _DRIVER = DirectPCA9685(bus_num=1)
    return _DRIVER


# ==============================================================================
# BATTERY READING VIA ADS1115
# ==============================================================================

def read_battery(bus, addr=0x48, channel=0, divider_ratio=5.0):
    try:
        mux = 0x04 + channel
        cfg_msb = 0x80 | (mux << 4) | (0b001 << 1) | 1  # 4.096V range, single-shot
        cfg_lsb = (0b100 << 5) | 0x03
        bus.write_i2c_block_data(addr, 0x01, [cfg_msb, cfg_lsb])
        time.sleep(0.01)
        data = bus.read_i2c_block_data(addr, 0x00, 2)
        raw = (data[0] << 8) | data[1]
        if raw >= 0x8000:
            raw -= 0x10000
        volts_pin = (raw * 4.096) / 32768.0
        v_bat = max(0.0, volts_pin * divider_ratio)
        pct = max(0.0, min(100.0, (v_bat - 6.6) / (8.4 - 6.6) * 100.0))
        status = "CRITICAL LOW" if v_bat < 6.8 else ("OK" if v_bat < 8.2 else "FULL")
        return v_bat, pct, status
    except Exception:
        return None


# ==============================================================================
# S-CURVE POWER-EFFICIENT RAMPING (C^1 Continuous)
# ==============================================================================

def soft_ramp_to(target_dict, duration_s=1.5, rate_hz=40):
    """
    Ramps multiple servos simultaneously using an S-curve cosine profile.
    Velocity starts at zero and ends at zero: zero acceleration jerk and zero current inrush.
    """
    drv = get_driver()
    steps = max(10, int(duration_s * rate_hz))
    dt = duration_s / steps

    starts = {}
    deltas = {}
    for sid, target_us in target_dict.items():
        start_us = CURRENT_US.get(sid, 1500.0)
        starts[sid] = start_us
        deltas[sid] = target_us - start_us

    for step in range(1, steps + 1):
        progress = step / steps
        # Cosine ease-in ease-out: 0.0 at progress=0, 1.0 at progress=1
        blend = 0.5 * (1.0 - math.cos(math.pi * progress))

        for sid, target_us in target_dict.items():
            sc = SERVOS[sid]
            us = starts[sid] + deltas[sid] * blend
            clamped = max(sc["min"], min(sc["max"], us))
            drv.set_pulse_us(sc["board"], sc["ch"], clamped)
            CURRENT_US[sid] = clamped

        time.sleep(dt)


# ==============================================================================
# MAIN MOTION SEQUENCE
# ==============================================================================

def run_stand_and_walk(duration_s=5.0, hold_s=2.5, speed="slow"):
    """
    Executes the full power-efficient motion sequence:
    1. Stand up softly.
    2. Hold posture still.
    3. Walk 2 legs at a time for duration_s.
    4. Return to center & release power completely.
    """
    drv = get_driver()
    cfg = SPEED_PRESETS[speed]

    print("\n" + "=" * 65)
    print("      QUADBOT POWER-EFFICIENT STAND & 2-LEG TROT WALK")
    print(f"      [Preset: {cfg['name']} | Duration: {duration_s:.1f}s | Hold: {hold_s:.1f}s]")
    print("=" * 65)

    # Battery check
    if drv.is_real and drv.smbus and drv.has_battery_adc:
        bat = read_battery(drv.smbus)
        if bat:
            print(f"--> Battery Status: {bat[0]:.2f}V ({int(bat[1])}%) [{bat[2]}]")
            if bat[0] < 6.8:
                print("[!] WARNING: Battery voltage is low! Consider recharging before high-draw tests.\n")

    # Clean release handler
    def cleanup():
        print("\n[STOP] Releasing power to all 12 servos (Limp Mode - 0.00A)...")
        drv.release_all()
        for sid in CURRENT_US:
            CURRENT_US[sid] = 1500.0

    atexit.register(cleanup)
    signal.signal(signal.SIGINT, lambda s, f: sys.exit(0))

    # --------------------------------------------------------------------------
    # STAGE 1: Smooth Stand-Up (S-Curve Jerk-Free Lift)
    # --------------------------------------------------------------------------
    stand_time = cfg["stand_ramp_s"]
    print(f"\n[STAGE 1/3] Standing up softly ({stand_time:.1f}s S-curve ramp)...")
    print("  -> Ramping all 12 servos smoothly to 1500us nominal stance.")
    print("  -> Peak current draw minimized through continuous cosine acceleration.")

    neutral_targets = {sid: 1500.0 for sid in SERVOS}
    soft_ramp_to(neutral_targets, duration_s=stand_time)
    print("  [OK] Robot is upright in nominal stance.")

    # --------------------------------------------------------------------------
    # STAGE 2: Hold Still
    # --------------------------------------------------------------------------
    print(f"\n[STAGE 2/3] Holding still for {hold_s:.1f} seconds...")
    print("  -> Servos holding posture with zero motion (holding torque only).")
    hold_steps = int(hold_s * 10)
    for i in range(hold_steps):
        time.sleep(0.1)
        remaining = hold_s - (i + 1) * 0.1
        sys.stdout.write(f"\r     Remaining hold: {max(0.0, remaining):.1f}s   ")
        sys.stdout.flush()
    print("\n  [OK] Hold posture verified.")

    # --------------------------------------------------------------------------
    # STAGE 3: 2-Legs-at-a-Time Forward Trot Walk (5.0 seconds)
    # --------------------------------------------------------------------------
    cycle_period_s = cfg["cycle_period_s"]
    coxa_swing_amp = cfg["coxa_swing_amp"]
    femur_lift_amp = cfg["femur_lift_amp"]
    tibia_fold_amp = cfg["tibia_fold_amp"]

    rate_hz = 40.0
    dt = 1.0 / rate_hz
    total_steps = int(duration_s * rate_hz)

    print(f"\n[STAGE 3/3] Walking forward 2 legs at a time for {duration_s:.1f} seconds...")
    print(f"  -> Diagonal Pair A: Front-Left (FL) + Rear-Right (RR)")
    print(f"  -> Diagonal Pair B: Front-Right (FR) + Rear-Left (RL)")
    print(f"  -> Motion amplitudes: Coxa: +/-{int(coxa_swing_amp)}us | Femur: +/-{int(femur_lift_amp)}us | Tibia: +/-{int(tibia_fold_amp)}us")
    print("  -> Press Ctrl+C at any time to safely abort.\n")

    t_start = time.monotonic()

    for step_i in range(total_steps):
        t_elapsed = time.monotonic() - t_start
        if t_elapsed >= duration_s:
            break

        # Cycle phase: 0.0 to 1.0
        phase = (t_elapsed / cycle_period_s) % 1.0

        # Sub-phase within half-cycle: 0.0 to 1.0
        # In a 2-leg trot gait:
        # Phase 0.0 to 0.5: Pair A swings forward, Pair B in stance pushing backward
        # Phase 0.5 to 1.0: Pair B swings forward, Pair A in stance pushing backward
        if phase < 0.5:
            # Pair A in Swing
            u_swing = phase / 0.5       # 0.0 -> 1.0
            lift_a = math.sin(math.pi * u_swing)
            # Smooth cosine forward sweep: from -amp to +amp
            coxa_prog_a = -math.cos(math.pi * u_swing)

            # Pair B in Stance
            u_stance = phase / 0.5      # 0.0 -> 1.0
            lift_b = 0.0
            # Smooth cosine backward sweep: from +amp to -amp
            coxa_prog_b = math.cos(math.pi * u_stance)
        else:
            # Pair B in Swing
            u_swing = (phase - 0.5) / 0.5  # 0.0 -> 1.0
            lift_b = math.sin(math.pi * u_swing)
            coxa_prog_b = -math.cos(math.pi * u_swing)

            # Pair A in Stance
            u_stance = (phase - 0.5) / 0.5  # 0.0 -> 1.0
            lift_a = 0.0
            coxa_prog_a = math.cos(math.pi * u_stance)

        # Apply to all 4 legs
        for leg_name in ["FL", "RR", "FR", "RL"]:
            is_pair_a = leg_name in PAIR_A
            lift = lift_a if is_pair_a else lift_b
            coxa_prog = coxa_prog_a if is_pair_a else coxa_prog_b

            # Forward swing: pulse increases (>1500us); Backward stance: pulse decreases (<1500us)
            coxa_pulse = 1500.0 + coxa_swing_amp * coxa_prog
            femur_pulse = 1500.0 - femur_lift_amp * lift
            tibia_pulse = 1500.0 + tibia_fold_amp * lift

            c_id = f"{leg_name}_coxa"
            f_id = f"{leg_name}_femur"
            t_id = f"{leg_name}_tibia"

            sc_c, sc_f, sc_t = SERVOS[c_id], SERVOS[f_id], SERVOS[t_id]

            # Safe hardware clamping
            c_p = max(sc_c["min"], min(sc_c["max"], coxa_pulse))
            f_p = max(sc_f["min"], min(sc_f["max"], femur_pulse))
            t_p = max(sc_t["min"], min(sc_t["max"], tibia_pulse))

            drv.set_pulse_us(sc_c["board"], sc_c["ch"], c_p)
            drv.set_pulse_us(sc_f["board"], sc_f["ch"], f_p)
            drv.set_pulse_us(sc_t["board"], sc_t["ch"], t_p)

            CURRENT_US[c_id] = c_p
            CURRENT_US[f_id] = f_p
            CURRENT_US[t_id] = t_p

        # Telemetry line
        if step_i % 10 == 0 or step_i == total_steps - 1:
            active_swing = "Pair A (FL+RR)" if phase < 0.5 else "Pair B (FR+RL)"
            sys.stdout.write(f"\r  Walking: {t_elapsed:.1f}s / {duration_s:.1f}s | Active Swing: {active_swing}   ")
            sys.stdout.flush()

        time.sleep(dt)

    t_total = time.monotonic() - t_start
    print(f"\n\n[OK] Forward walk finished ({t_total:.1f}s elapsed).")

    # --------------------------------------------------------------------------
    # STAGE 4: Return to Neutral & Power-Saving Cut (0.00A)
    # --------------------------------------------------------------------------
    print("\n[STAGE 4/4] Returning to neutral stance and releasing power...")
    soft_ramp_to({sid: 1500.0 for sid in SERVOS}, duration_s=1.0)
    time.sleep(0.3)

    drv.release_all()
    print("[SUCCESS] All 12 servos released to limp mode (zero holding current).")

    if drv.is_real and drv.smbus and drv.has_battery_adc:
        bat = read_battery(drv.smbus)
        if bat:
            print(f"--> Post-Walk Battery: {bat[0]:.2f}V ({int(bat[1])}%) [{bat[2]}]")

    print("\n" + "=" * 65)
    print("      RUN COMPLETE: Stand Up -> Hold Still -> 5s Trot Walk")
    print("=" * 65 + "\n")


# ==============================================================================
# CLI DISPATCH
# ==============================================================================

def main():
    parser = argparse.ArgumentParser(
        description="Power-Efficient Stand, Hold Still, & 2-Leg Trot Walk for Quadbot",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  python stand_and_walk.py                    # Standard 5s walk with 2.5s hold
  python stand_and_walk.py --duration 7.0     # Walk for 7 seconds
  python stand_and_walk.py --hold 3.0         # Hold still for 3 seconds before walking
  python stand_and_walk.py --speed normal     # Use normal speed preset
  python stand_and_walk.py --battery          # Read 2S battery voltage
  python stand_and_walk.py --scan             # Scan I2C bus and unlock boards
  python stand_and_walk.py --release          # Cut power to all servos immediately
        """
    )
    parser.add_argument("--duration", type=float, default=5.0,
                        help="Duration of 2-leg forward walking in seconds (default: 5.0)")
    parser.add_argument("--hold", type=float, default=2.5,
                        help="Duration to hold still in seconds (default: 2.5)")
    parser.add_argument("--speed", choices=["slow", "normal"], default="slow",
                        help="Speed preset: 'slow' (power efficient, default) or 'normal'")
    parser.add_argument("--scan", action="store_true",
                        help="Scan I2C bus and unlock PCA9685 controllers")
    parser.add_argument("--battery", action="store_true",
                        help="Read 2S battery voltage via ADS1115")
    parser.add_argument("--release", action="store_true",
                        help="Cut power to all servos immediately (limp mode)")

    args = parser.parse_args()

    drv = get_driver()

    if args.release:
        print("\n[STOP] Releasing all servos (cutting power)...")
        drv.release_all()
        print("[OK] All servos are limp (0.00A current draw).\n")
        return

    if args.scan:
        print("\n[OK] Hardware bus scan and initialization complete.\n")
        return

    if args.battery:
        if drv.is_real and drv.smbus and drv.has_battery_adc:
            bat = read_battery(drv.smbus)
            if bat:
                print(f"\n[BATTERY] 2S LiPo: {bat[0]:.2f}V ({int(bat[1])}%) [{bat[2]}]\n")
            else:
                print("\n[BATTERY] Could not read voltage from ADS1115.\n")
        else:
            print("\n[BATTERY] ADS1115 ADC not detected or running in simulation mode.\n")
        return

    # Run the full sequence
    run_stand_and_walk(duration_s=args.duration, hold_s=args.hold, speed=args.speed)


if __name__ == "__main__":
    main()
