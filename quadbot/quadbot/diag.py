"""Standalone hardware diagnostic & bring-up utility for quadbot.

Allows testing gait and motion on INDIVIDUAL SERVOS or SINGLE LEGS,
eliminating high current draw and avoiding power supply brownouts.

Run on the Raspberry Pi:
    python -m quadbot.diag

Run specific single-servo or single-leg gait tests:
    python -m quadbot.diag --gait-servo FL_femur   # Only 1 servo powered!
    python -m quadbot.diag --gait-leg FL          # Only 3 servos powered!
    python -m quadbot.diag --gait-board left      # Only 6 servos powered!
    python -m quadbot.diag --stand-leg FL         # Stand pose on 1 leg
    python -m quadbot.diag --test-servo FL_coxa   # Jog single servo
    python -m quadbot.diag --scan                 # Scan I2C for 0x40 and 0x50
    python -m quadbot.diag --all-1500             # Soft-center all 12
    python -m quadbot.diag --release              # Release all servos
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
        print("    1. ADS1115 Level Shifter: If recently wired, disconnect its SDA & SCL")
        print("       wires from the Pi. A miswired level shifter pulls the entire bus LOW.")
        print("    2. Enable I2C: sudo raspi-config -> Interface Options -> I2C -> Yes")
        print("    3. Check Pi pin 1 (3.3V) -> PCA9685 VCC (both boards)")
        print("    4. Check Pi pin 6 (GND) -> PCA9685 GND (both boards)")
        print("    5. Check Pi pin 3 (SDA) -> PCA9685 SDA (both boards)")
        print("    6. Check Pi pin 5 (SCL) -> PCA9685 SCL (both boards)")
        print("    7. Check Servo V+ power terminal (2S battery / UBEC switch).")
        return False

    print(f"Detected I2C addresses on /dev/i2c-1: {[hex(a) for a in found]}")
    left_ok = 0x40 in found
    right_ok = 0x50 in found
    ads_ok = 0x48 in found

    print(f"  * Left Board  (0x40): {'[OK] Detected' if left_ok else '[FAIL] Missing!'}")
    print(f"  * Right Board (0x50): {'[OK] Detected' if right_ok else '[FAIL] Missing! (Verify A4 solder jumper)'}")
    print(f"  * ADS1115 ADC (0x48): {'[OK] Detected (2S Battery monitor active)' if ads_ok else '[--] Not detected (Battery monitor optional)'}")

    # Unlock PCA9685 boards in case ALL_LED_OFF bit was latched
    try:
        from smbus2 import SMBus
        with SMBus(1) as bus:
            for addr in (0x40, 0x50):
                if addr in found:
                    try:
                        bus.write_byte_data(addr, 0x00, 0x20)  # wake + auto-inc
                        bus.write_byte_data(addr, 0x01, 0x04)  # totem-pole push-pull
                        bus.write_byte_data(addr, 0xFD, 0x00)  # clear ALL_LED_OFF
                        bus.write_byte_data(addr, 0xFB, 0x00)  # clear ALL_LED_ON
                    except Exception:
                        pass
    except Exception:
        pass

    if not left_ok or not right_ok:
        print("\n[!] WARNING: Both boards must be detected for normal operation.")
        if not right_ok:
            print("    -> For Right Board (0x50): Bridge solder pads for A4 on the PCA9685.")
            print("       If your board has address 0x41 (A0 bridged), change address in config/robot.yaml.")
    return left_ok and right_ok


def test_single_servo(driver, servo, duration_s=2.5):
    """Gently jog a single servo back and forth to verify wiring."""
    print(f"\n---> Testing Servo: {servo.id} (Board: {servo.board}, Ch: {servo.channel})")
    center = servo.us_center
    is_coxa = "coxa" in servo.id
    deg_step = 6 if is_coxa else 10
    dwell = 0.6 if is_coxa else 0.4
    print(f"     Jogging: Center -> +{deg_step}° -> -{deg_step}° -> Center (Dwell: {dwell}s) ...")
    step = deg_step * servo.us_per_deg * (1 if not servo.invert else -1)
    
    t0 = time.monotonic()
    try:
        while time.monotonic() - t0 < duration_s:
            driver.set_pulse(servo.channel, center + step, board=servo.board)
            time.sleep(dwell)
            driver.set_pulse(servo.channel, center - step, board=servo.board)
            time.sleep(dwell)
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


def test_stand_pose(driver, cfg, servos, duration_s=4.0, target=None):
    """Calculate and set legs into stand pose using kinematics. Supports single leg/servo targeting."""
    active_sids = set()
    if target in servos:
        active_sids.add(target)
        desc = f"Single Servo '{target}'"
    elif target in ("FL", "FR", "RL", "RR"):
        active_sids.update(f"{target}_{j}" for j in ("coxa", "femur", "tibia") if f"{target}_{j}" in servos)
        desc = f"Single Leg '{target}' (3 servos)"
    elif target in ("left", "right"):
        active_sids.update(s.id for s in servos.values() if s.board == target)
        desc = f"{target.capitalize()} Board (6 servos)"
    else:
        active_sids.update(servos.keys())
        desc = "All 12 Servos"

    driver.release_all()
    print(f"\n---> Commanding Stand Pose on {desc} (height={cfg['gait']['height_stand']} mm)...")
    g = cfg["geometry"]
    kin = LegKinematics(g["coxa"], g["femur"], g["tibia"])
    gait = GaitEngine(cfg)
    feet = gait.nominal(cfg["gait"]["height_stand"])

    targets = {}
    for leg, (x, y, z) in feet.items():
        th1, a, b, ok = kin.ik_deg(x, y, z)
        targets[f"{leg}_coxa"] = th1
        targets[f"{leg}_femur"] = a
        targets[f"{leg}_tibia"] = b

    for sid in active_sids:
        us = servos[sid].deg_to_us(targets[sid])
        driver.set_pulse(servos[sid].channel, us, board=servos[sid].board)
        time.sleep(0.04)
    print(f"     [OK] In Stand Pose. Holding for {duration_s} seconds...")
    time.sleep(duration_s)
    driver.release_all()
    print("     Released.")


def run_gait_test(driver, cfg, servos, mode="crawl", cmd=(0.6, 0.0, 0.0), duration_s=6.0, target=None):
    """Run real walking gait test directly in terminal.
    Can run on an INDIVIDUAL SERVO, a SINGLE LEG, a SINGLE BOARD, or ALL SERVOS.
    Unselected servos are completely released/unpowered (0mA current draw).
    """
    g = cfg["geometry"]
    kin = LegKinematics(g["coxa"], g["femur"], g["tibia"])
    gait = GaitEngine(cfg)

    # Resolve active servos
    active_sids = set()
    if target in servos:
        active_sids.add(target)
        desc = f"Single Servo '{target}' (1 servo active, low-power safe)"
    elif target in ("FL", "FR", "RL", "RR"):
        active_sids.update(f"{target}_{j}" for j in ("coxa", "femur", "tibia") if f"{target}_{j}" in servos)
        desc = f"Single Leg '{target}' (3 servos active, low-power safe)"
    elif target in ("left", "right"):
        active_sids.update(s.id for s in servos.values() if s.board == target)
        desc = f"{target.capitalize()} Board ({len(active_sids)} servos active)"
    else:
        active_sids.update(servos.keys())
        desc = f"All 12 Servos ({len(active_sids)} active)"

    # Release everything first so only target receives pulses
    driver.release_all()

    print(f"\n---> Running Gait Test: {mode.upper()} with cmd={cmd}")
    print(f"     Target: {desc} | Duration: {duration_s}s...")
    
    t0 = time.monotonic()
    dt = 0.02
    last_print = 0.0
    while time.monotonic() - t0 < duration_s:
        t_start = time.perf_counter()
        feet = gait.update(dt, mode, cmd)
        for leg, (x, y, z) in feet.items():
            th1, a, b, ok = kin.ik_deg(x, y, z)
            leg_targets = {
                f"{leg}_coxa": th1,
                f"{leg}_femur": a,
                f"{leg}_tibia": b
            }
            for sid in active_sids:
                if sid in leg_targets:
                    driver.set_pulse(servos[sid].channel, servos[sid].deg_to_us(leg_targets[sid]), board=servos[sid].board)
        
        elapsed = time.monotonic() - t0
        if elapsed - last_print > 1.0:
            last_print = elapsed
            print(f"     Walking... {elapsed:.1f}s / {duration_s}s | Active: {len(active_sids)} servos | Swing: {gait.swing}")
        
        took = time.perf_counter() - t_start
        if took < dt:
            time.sleep(dt - took)
    driver.release_all()
    print("     Gait test complete & all servos released.")


def interactive_menu(cfg, driver, servos):
    while True:
        print("\n" + "=" * 60)
        print("          QUADBOT HARDWARE & GAIT DIAGNOSTIC MENU")
        print("=" * 60)
        print("  1. I2C Bus Scan (Check 0x40 & 0x50)")
        print("  2. Test Single Servo Jog (Cycle through joints)")
        print("  3. Test Single Leg Jog (FL, FR, RL, RR)")
        print("  4. GAIT WALK TEST: Single Servo (Only 1 servo powered!)")
        print("  5. GAIT WALK TEST: Single Leg (Only 3 servos powered!)")
        print("  6. GAIT WALK TEST: Single Board (6 servos: Left or Right)")
        print("  7. Stand Pose Test (Single Leg or All)")
        print("  8. Soft Center All 12 Servos (1500 µs)")
        print("  9. Release All Servos (Limp / Safe)")
        print(" 10. Full 12-Servo Crawl Walk Test")
        print(" 11. Full 12-Servo Turn Test")
        print(" 12. Hardware Jitter Troubleshooting Guide")
        print("  0. Exit")
        print("=" * 60)

        choice = input("Enter choice (0-12): ").strip()
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
            print("\nSelect servo to test gait on (ONLY this servo will move):")
            s_list = list(servos.keys())
            for i, sid in enumerate(s_list):
                print(f"  {i + 1:2d}. {sid}")
            sel = input("Pick servo number or id: ").strip()
            sid = s_list[int(sel) - 1] if sel.isdigit() and 1 <= int(sel) <= len(s_list) else sel
            if sid in servos:
                run_gait_test(driver, cfg, servos, mode="crawl", cmd=(0.6, 0.0, 0.0), duration_s=5.0, target=sid)
            else:
                print("Invalid servo.")
        elif choice == "5":
            leg = input("Enter leg to test gait (FL, FR, RL, RR): ").strip().upper()
            if leg in ("FL", "FR", "RL", "RR"):
                run_gait_test(driver, cfg, servos, mode="crawl", cmd=(0.6, 0.0, 0.0), duration_s=5.0, target=leg)
            else:
                print("Invalid leg name.")
        elif choice == "6":
            b = input("Enter board to test (left or right): ").strip().lower()
            if b in ("left", "right"):
                run_gait_test(driver, cfg, servos, mode="crawl", cmd=(0.6, 0.0, 0.0), duration_s=5.0, target=b)
            else:
                print("Invalid board name.")
        elif choice == "7":
            leg = input("Enter leg for stand pose (FL, FR, RL, RR or 'all'): ").strip().upper()
            target = leg if leg in ("FL", "FR", "RL", "RR") else None
            test_stand_pose(driver, cfg, servos, duration_s=4.0, target=target)
        elif choice == "8":
            soft_center_all(driver, servos)
        elif choice == "9":
            driver.release_all()
            print("All servos released (limp).")
        elif choice == "10":
            run_gait_test(driver, cfg, servos, mode="crawl", cmd=(0.6, 0.0, 0.0), duration_s=5.0)
        elif choice == "11":
            run_gait_test(driver, cfg, servos, mode="crawl", cmd=(0.0, 0.0, 0.8), duration_s=5.0)
        elif choice == "12":
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

3. TESTING WITH LOW POWER:
   - Use 'python -m quadbot.diag --gait-leg FL' to test 1 leg (only 3 servos).
   - Use 'python -m quadbot.diag --gait-servo FL_femur' to test 1 joint.
   - This lets you verify gaits and kinematics even with a 2A bench supply!

4. LOGIC VOLTAGE vs SERVO VOLTAGE:
   - PCA9685 VCC (logic): Connect to Pi 3.3V (Pin 1).
   - PCA9685 V+ (screw terminal): Connect to external 5V-6V battery/BEC.
   - NEVER connect 5V-6V to the PCA9685 VCC pin (it can back-feed the Pi 3.3V rail).

5. SOLDER JUMPERS:
   - Left PCA9685: 0x40 (default, no solder jumpers).
   - Right PCA9685: 0x50 (bridge A4 pads).
""")
    print("=" * 65)


def main():
    ap = argparse.ArgumentParser(description="Quadbot Hardware Diagnostic & Gait Testing Tool")
    ap.add_argument("--config", default=str(ROOT / "config" / "robot.yaml"))
    ap.add_argument("--scan", action="store_true", help="Scan I2C bus for 0x40 and 0x50")
    ap.add_argument("--test-servo", help="Test a single servo jog (e.g. FL_coxa)")
    ap.add_argument("--test-leg", help="Test a single leg jog (FL, FR, RL, RR)")
    ap.add_argument("--gait-servo", help="Run crawl gait on a SINGLE SERVO ONLY (e.g. FL_femur)")
    ap.add_argument("--gait-leg", help="Run crawl gait on a SINGLE LEG ONLY (FL, FR, RL, RR)")
    ap.add_argument("--gait-board", help="Run crawl gait on ONE BOARD ONLY (left or right)")
    ap.add_argument("--stand-leg", help="Hold stand pose on ONE LEG ONLY (FL, FR, RL, RR)")
    ap.add_argument("--all-1500", action="store_true", help="Soft-center all servos to 1500 us")
    ap.add_argument("--stand", action="store_true", help="Hold stand pose on all legs")
    ap.add_argument("--crawl", action="store_true", help="Run crawl forward gait test on all legs")
    ap.add_argument("--turn", action="store_true", help="Run turn in place gait test on all legs")
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
        elif args.gait_servo:
            if args.gait_servo in servos:
                run_gait_test(driver, cfg, servos, mode="crawl", cmd=(0.6, 0.0, 0.0), duration_s=5.0, target=args.gait_servo)
            else:
                print(f"Unknown servo '{args.gait_servo}'. Valid: {list(servos.keys())}")
        elif args.gait_leg:
            leg = args.gait_leg.upper()
            if leg in ("FL", "FR", "RL", "RR"):
                run_gait_test(driver, cfg, servos, mode="crawl", cmd=(0.6, 0.0, 0.0), duration_s=5.0, target=leg)
            else:
                print(f"Invalid leg '{args.gait_leg}'. Valid: FL, FR, RL, RR")
        elif args.gait_board:
            b = args.gait_board.lower()
            if b in ("left", "right"):
                run_gait_test(driver, cfg, servos, mode="crawl", cmd=(0.6, 0.0, 0.0), duration_s=5.0, target=b)
            else:
                print(f"Invalid board '{args.gait_board}'. Valid: left, right")
        elif args.stand_leg:
            leg = args.stand_leg.upper()
            if leg in ("FL", "FR", "RL", "RR"):
                test_stand_pose(driver, cfg, servos, duration_s=4.0, target=leg)
            else:
                print(f"Invalid leg '{args.stand_leg}'. Valid: FL, FR, RL, RR")
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
        elif args.crawl:
            run_gait_test(driver, cfg, servos, mode="crawl", cmd=(0.6, 0.0, 0.0), duration_s=5.0)
        elif args.turn:
            run_gait_test(driver, cfg, servos, mode="crawl", cmd=(0.0, 0.0, 0.8), duration_s=5.0)
        else:
            interactive_menu(cfg, driver, servos)
    finally:
        driver.close()


if __name__ == "__main__":
    main()
