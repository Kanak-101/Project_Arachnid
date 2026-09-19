from __future__ import annotations

import argparse
import sys
from pathlib import Path

# Add src to python path for standalone script execution
sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "src"))

from arachnid_interaction.behavior.motions import MotionConfig, create_dance, create_leg_wave, create_shake
from arachnid_interaction.commands import Command, MotionCommand
from arachnid_interaction.control.transport import create_transport


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Manual laptop control for Project Arachnid (W=LEG_WAVE, S=SHAKE, D=DANCE, X=STOP, Q=QUIT)"
    )
    parser.add_argument(
        "--transport",
        choices=("console", "serial", "tcp"),
        default="console",
        help="Command transport type",
    )
    parser.add_argument("--serial-port", default="COM4", help="Serial port for robot controller")
    parser.add_argument("--serial-baudrate", type=int, default=115200, help="Serial baudrate")
    parser.add_argument("--tcp-host", default="127.0.0.1", help="TCP host for controller")
    parser.add_argument("--tcp-port", type=int, default=8765, help="TCP port for controller")
    args = parser.parse_args()

    motion_config = MotionConfig(
        leg_wave_duration_s=6.0,
        shake_duration_s=6.0,
        dance_duration_s=8.0,
    )

    sink = create_transport({
        "type": args.transport,
        "serial_port": args.serial_port,
        "serial_baudrate": args.serial_baudrate,
        "tcp_host": args.tcp_host,
        "tcp_port": args.tcp_port,
        "repeat_interval_s": 0.0,
    })

    print("==================================================")
    print("Project Arachnid — Manual Laptop Control Interface")
    print("==================================================")
    print("Commands:")
    print("  W -> LEG_WAVE (6.0s)")
    print("  S -> SHAKE    (6.0s)")
    print("  D -> DANCE    (8.0s)")
    print("  X -> STOP     (immediate)")
    print("  Q -> QUIT")
    print(f"Active transport: {args.transport.upper()}")
    print("==================================================")

    try:
        while True:
            try:
                raw = input("> ").strip().lower()
            except (EOFError, KeyboardInterrupt):
                break

            if not raw:
                continue

            if raw == "q":
                sink.stop()
                print("Exiting manual control.")
                break
            elif raw == "w":
                cmd = create_leg_wave(motion_config)
                sink.send(cmd)
            elif raw == "s":
                cmd = create_shake(motion_config)
                sink.send(cmd)
            elif raw == "d":
                cmd = create_dance(motion_config)
                sink.send(cmd)
            elif raw == "x":
                cmd = MotionCommand(Command.STOP, duration_s=0.0, parameters={"reason": "manual_stop"})
                sink.send(cmd)
            else:
                print(f"Unknown command {raw!r}. Use W, S, D, X, or Q.")
    finally:
        sink.close()


if __name__ == "__main__":
    main()
