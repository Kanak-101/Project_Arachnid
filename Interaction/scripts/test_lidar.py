from __future__ import annotations

import argparse
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "src"))

import time

from arachnid_interaction.navigation.lidar import LidarReader


def main() -> None:
    parser = argparse.ArgumentParser(description="Check RPLIDAR input")
    parser.add_argument("port")
    parser.add_argument("--baudrate", type=int, default=115200)
    args = parser.parse_args()

    lidar = LidarReader(args.port, args.baudrate)
    lidar.start()
    try:
        print("Reading LiDAR. Press Ctrl+C to stop.")
        while True:
            front = lidar.distance_at(0.0, 10.0)
            left = lidar.distance_at(270.0, 10.0)
            right = lidar.distance_at(90.0, 10.0)
            print(f"front={front!r} left={left!r} right={right!r}")
            time.sleep(0.25)
    except KeyboardInterrupt:
        pass
    finally:
        lidar.stop()


if __name__ == "__main__":
    main()
