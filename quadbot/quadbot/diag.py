"""Standalone hardware diagnostic & bring-up utility for quadbot.

Run on the Raspberry Pi:
    python -m quadbot.diag
or with flags:
    python -m quadbot.diag --scan
    python -m quadbot.diag --test-servo FL_coxa
    python -m quadbot.diag --test-leg FL
    python -m quadbot.diag --all-1500
    python -m quadbot.diag --stand
    python -m quadbot.diag --crawl
    python -m quadbot.diag --turn
    python -m quadbot.diag --release
"""
import argparse
import sys
import time
from pathlib import Path

from . import config as cfgmod
from .gait import GaitEngine
from .hal import PCA9685Driver, make_driver
from .kinematics import LegKinematics

ROOT = Path(__file__).resolve().parent.parent


def scan_i2c_bus(bus_num=1):
    """Scan I2C bus and return list of detected addresses in hex."""
    found = []
    try:
        from smbus2 import SMBus
        with SMBus(bus_num) as bus:
            for addr in range(0x03, 0x78):
                try:
                    bus.read_byte(addr)
                    found.append(addr)
                except OSError:
                    pass
    except Exception as e:
        print(f"[!] Could not access /dev/i2c-{bus_num}: {e}")
        return []
    return found


def print_i2c_report(found):
    print("\n" + "=" * 55)
    print("           I2C HARDWARE SCAN REPORT")
    print("=" * 55)
    if not found:
        print("[!] No I2C devices responded on bus 1.")
        print("    Troubleshooting steps:")
        print("    1. Enable I2C: sudo raspi-config -> Interface Options -> I2C -> Yes")
        print("    2. Check Pi pin 1 (3.3V) -> PCA9685 VCC (both boards)")
        print("    3. Check Pi pin 6 (GND) -> PCA9685 GND (both boards)")
        print("    4. Check Pi pin 3 (SDA) -> PCA9685 SDA (both boards)")
        print("    5. Check Pi pin 5 (SCL) -> PCA9685 SCL (both boards)")
        print("    6. Verify I2C bus permissions: sudo usermod -aG i2c $USER")
        return False

    print(f"Detected I2C addresses on /dev/i2c-1: {[hex(a) for a in found]}")
    left_ok = 0x40 in found
    right_ok = 0x50 in found

    print(f"  * Left Board  (0x40): {'[OK] Detected' if left_ok else '[FAIL] Missing!'}")
    print(f"  * Right Board (0x50): {'[OK] Detected' if right_ok else '[FAIL] Missing! (Verify A4 solder jumper)'}")

    if not left_ok or not right_ok:
        print("\n[!] WARNING: Both boards must be detected for normal operation.")
        if not right_ok:
            print("    -> For Right Board (0x50): Bridge solder pads for A4 on the PCA9685.")
            print("       If your board has address 0x41 (A0 bridged), change address in config/robot.yaml.")
    return left_ok and right_ok


def test_single_servo(driver, servo, duration_s=2.5):
    """Gently jog a single servo back and forth to verify wiring."""
    print(f"\n---> Testing Servo: {servo.id} (Board: {servo.board}, Ch: {servo.channel})")
    print("     Jogging: Center -> +12° -> -12° -> Center ...")
    center = servo.us_center
    step = 12 * servo.us_per_deg * (1 if not servo.invert else -1)
    
    t0 = time.monotonic()
    try:
        while time.monotonic() - t0 < duration_s:
            driver.set_pulse(servo.channel, center + step, board=servo.board)
            time.sleep(0.4)
            driver.set_pulse(servo.channel, center - step, board=servo.board)
            time.sleep(0.4)
        driver.set_pulse(servo.channel, center, board=servo.board)
        time.sleep(0.2)
    finally:
        driver.release(servo.channel, board=servo.board)
        print(f"     Finished & released {servo.id}.")


def soft_center_all(driver, servos, delay_s=0.15):
    """Enable and center all servos sequentially to avoid power brownouts."""
    print("\n---> Soft-centering all 12 servos to 1500 µs (sequential soft start)...")
    for sid, s in servos.items():
        print(f"     Centering {sid:10s} (board: {s.board}, ch: {s.channel})...")
        driver.set_pulse(s.channel, s.us_center, board=s.board)
        time.sleep(delay_s)
    print("     [OK] All 12 servos centered at 1500 µs.")


def test_stand_pose(driver, cfg, servos, duration_s=4.0):
    """Calculate and set the 4 legs into the stand pose using kinematics."""
    print(f"\n---> Commanding Stand Pose (height={cfg['gait']['height_stand']} mm)...")
    g = cfg["geometry"]
    kin = LegKinematics(g["coxa"], g["femur"], g["tibia"])
    gait = GaitEngine(cfg)
    feet = gait.nominal(cfg["gait"]["height_stand"])

    # Calculate angles
    targets = {}
    for leg, (x, y, z) in feet.items():
        th1, a, b, ok = kin.ik_deg(x, y, z)
        targets[f"{leg}_coxa"] = th1
        targets[f"{leg}_femur"] = a
        targets[f"{leg}_tibia"] = b

    # Ramp each servo to target
    for sid, s in servos.items():
        us = s.deg_to_us(targets[sid])
        driver.set_pulse(s.channel, us, board=s.board)
        time.sleep(0.05)
    print("     [OK] In Stand Pose. Holding for", duration_s, "seconds...")
    time.sleep(duration_s)


def run_gait_test(driver, cfg, servos, mode="crawl", cmd=(0.6, 0.0, 0.0), duration_s=6.0):
    """Run real walking gait test directly in terminal."""
    g = cfg["geometry"]
    kin = LegKinematics(g["coxa"], g["femur"], g["tibia"])
    gait = GaitEngine(cfg)
    print(f"\n---> Running Gait Test: {mode.upper()} with cmd={cmd} for {duration_s}s...")
    
    t0 = time.monotonic()
    dt = 0.02
    last_print = 0.0
    while time.monotonic() - t0 < duration_s:
        t_start = time.perf_counter()
        feet = gait.update(dt, mode, cmd)
        for leg, (x, y, z) in feet.items():
            th1, a, b, ok = kin.ik_deg(x, y, z)
            driver.set_pulse(servos[f"{leg}_coxa"].channel, servos[f"{leg}_coxa"].deg_to_us(th1), board=servos[f"{leg}_coxa"].board)
            driver.set_pulse(servos[f"{leg}_femur"].channel, servos[f"{leg}_femur"].deg_to_us(a), board=servos[f"{leg}_femur"].board)
            driver.set_pulse(servos[f"{leg}_tibia"].channel, servos[f"{leg}_tibia"].deg_to_us(b), board=servos[f"{leg}_tibia"].board)
        
        elapsed = time.monotonic() - t0
        if elapsed - last_print > 1.0:
            last_print = elapsed
            print(f"     Walking... {elapsed:.1f}s / {duration_s}s | Swing legs: {gait.swing}")
        
        took = time.perf_counter() - t_start
        if took < dt:
            time.sleep(dt - took)
    print("     Gait test complete.")


def interactive_menu(cfg, driver, servos):
    while True:
        print("\n" + "=" * 55)
        print("           QUADBOT DIAGNOSTIC & DEBUG MENU")
        print("=" * 55)
        print("  1. I2C Bus Scan (Check 0x40 & 0x50)")
        print("  2. Test Single Servo (Cycle through joints)")
        print("  3. Test Single Leg (FL, FR, RL, or RR)")
        print("  4. Soft Center All 12 Servos (1500 µs)")
        print("  5. Test Stand Pose (Kinematics IK)")
        print("  6. Test Crawl Walk (Forward)")
        print("  7. Test Turn (Rotate in place)")
        print("  8. Release All Servos (Limp / Safe)")
        print("  9. Hardware Jitter Troubleshooting Guide")
        print("  0. Exit")
        print("=" * 55)

        choice = input("Enter choice (0-9): ").strip()
        if choice == "1":
            found = scan_i2c_bus(1)
            print_i2c_report(found)
        elif choice == "2":
            print("\nAvailable servos:")
            s_list = list(servos.keys())
            for i, sid in enumerate(s_list):
                print(f"  {i + 1:2d}. {sid} ({servos[sid].board}, ch {servos[sid].channel})")
            sel = input("Pick a servo number or id: ").strip()
            sid = None
            if sel.isdigit() and 1 <= int(sel) <= len(s_list):
                sid = s_list[int(sel) - 1]
            elif sel in servos:
                sid = sel
            if sid:
                test_single_servo(driver, servos[sid])
            else:
                print("Invalid servo selection.")
        elif choice == "3":
            leg = input("Enter leg (FL, FR, RL, RR): ").strip().upper()
            if leg in ("FL", "FR", "RL", "RR"):
                for j in ("coxa", "femur", "tibia"):
                    sid = f"{leg}_{j}"
                    test_single_servo(driver, servos[sid], duration_s=1.5)
            else:
                print("Invalid leg name.")
        elif choice == "4":
            soft_center_all(driver, servos)
        elif choice == "5":
            test_stand_pose(driver, cfg, servos)
        elif choice == "6":
            run_gait_test(driver, cfg, servos, mode="crawl", cmd=(0.6, 0.0, 0.0), duration_s=5.0)
            driver.release_all()
        elif choice == "7":
            run_gait_test(driver, cfg, servos, mode="crawl", cmd=(0.0, 0.0, 0.8), duration_s=5.0)
            driver.release_all()
        elif choice == "8":
            driver.release_all()
            print("All servos released (limp).")
        elif choice == "9":
            print_jitter_guide()
        elif choice == "0":
            driver.release_all()
            print("Exiting diagnostics.")
            break
        else:
            print("Invalid option.")


def print_jitter_guide():
    print("\n" + "=" * 65)
    print("      SERVO JITTER & VOLTAGE BROWNOUT TROUBLESHOOTING GUIDE")
    print("=" * 65)
    print("""
1. COMMON GROUND (Most Common Cause of Jitter):
   - The PCA9685 GND MUST be tied to the Raspberry Pi GND (Pin 6).
   - The Servo Power Supply GND MUST also be connected to the SAME GND.
   - If servo GND and Pi GND are separate, the PWM signal reference floats,
     causing rapid, violent servo chatter/twitching!

2. POWER SUPPLY CURRENT CAPACITY:
   - 12 MG958 / MG996R / MG995 servos draw 1.0A - 2.5A peak stall EACH.
   - Total peak current can reach 10A - 15A during sudden moves!
   - If using a battery or BEC, it MUST be capable of at least 8A - 10A @ 5V-6V.
   - If your power supply drops below 4.5V, the servo internal microcontroller
     browns out and resets continuously (sounds like clicking/buzzing).

3. LOGIC VOLTAGE vs SERVO VOLTAGE:
   - PCA9685 VCC (logic): Connect to Pi 3.3V (Pin 1).
   - PCA9685 V+ (screw terminal): Connect to external 5V-6V battery/BEC.
   - NEVER connect 5V-6V to the PCA9685 VCC pin (it can back-feed the Pi 3.3V rail).

4. PHASE STAGGERING:
   - In quadbot/hal.py, phase staggering is ENABLED by default. This spreads
     the rising edge of PWM pulses across the 20ms frame so all 12 motors
     never draw initial inrush on the exact same microsecond tick.

5. SOLDER JUMPERS:
   - Left PCA9685: 0x40 (default, no solder jumpers).
   - Right PCA9685: 0x50 (bridge A4 pads).
   - If you bridged A0 instead, the address is 0x41. Edit config/robot.yaml accordingly.
""")
    print("=" * 65)


def main():
    ap = argparse.ArgumentParser(description="Quadbot Hardware Diagnostic Tool")
    ap.add_argument("--config", default=str(ROOT / "config" / "robot.yaml"))
    ap.add_argument("--scan", action="store_true", help="Scan I2C bus for 0x40 and 0x50")
    ap.add_argument("--test-servo", help="Test a single servo (e.g. FL_coxa)")
    ap.add_argument("--test-leg", help="Test a single leg (FL, FR, RL, RR)")
    ap.add_argument("--all-1500", action="store_true", help="Soft-center all servos to 1500 us")
    ap.add_argument("--stand", action="store_true", help="Hold stand pose")
    ap.add_argument("--crawl", action="store_true", help="Run crawl forward gait test")
    ap.add_argument("--turn", action="store_true", help="Run turn in place gait test")
    ap.add_argument("--release", action="store_true", help="Release all servos")
    ap.add_argument("--jitter-guide", action="store_true", help="Print jitter troubleshooting guide")
    args = ap.parse_args()

    cfg = cfgmod.load(args.config)
    from .servos import ServoCal
    servos = {s["id"]: ServoCal.from_dict(s) for s in cfg["servos"]}
    for sid, s in servos.items():
        if not s.board or s.board == "default":
            s.board = "left" if s.leg in ("FL", "RL") else "right"

    if args.jitter_guide:
        print_jitter_guide()
        return

    if args.scan:
        found = scan_i2c_bus(1)
        print_i2c_report(found)
        return

    # Initialize driver
    try:
        driver = make_driver(cfg)
    except Exception as e:
        print(f"[!] Could not initialize driver: {e}")
        print("    Running I2C bus scan to diagnose...")
        scan_i2c_bus(1)
        return

    try:
        if args.release:
            driver.release_all()
            print("All servos released.")
        elif args.test_servo:
            if args.test_servo in servos:
                test_single_servo(driver, servos[args.test_servo])
            else:
                print(f"Unknown servo '{args.test_servo}'. Valid: {list(servos.keys())}")
        elif args.test_leg:
            leg = args.test_leg.upper()
            for j in ("coxa", "femur", "tibia"):
                sid = f"{leg}_{j}"
                if sid in servos:
                    test_single_servo(driver, servos[sid], duration_s=1.5)
        elif args.all_1500:
            soft_center_all(driver, servos)
        elif args.stand:
            test_stand_pose(driver, cfg, servos)
            driver.release_all()
        elif args.crawl:
            run_gait_test(driver, cfg, servos, mode="crawl", cmd=(0.6, 0.0, 0.0), duration_s=5.0)
            driver.release_all()
        elif args.turn:
            run_gait_test(driver, cfg, servos, mode="crawl", cmd=(0.0, 0.0, 0.8), duration_s=5.0)
            driver.release_all()
        else:
            # Interactive menu
            interactive_menu(cfg, driver, servos)
    finally:
        driver.close()


if __name__ == "__main__":
    main()
