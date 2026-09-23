from __future__ import annotations

import argparse
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "src"))


import cv2

from arachnid_interaction.camera import Camera


def main() -> None:
    parser = argparse.ArgumentParser(description="Check laptop camera capture")
    parser.add_argument("--camera", default="0")
    args = parser.parse_args()
    source = int(args.camera) if args.camera.isdigit() else args.camera
    camera = Camera(source=source, width=640, height=480, fps=30)
    try:
        while True:
            frame = camera.read()
            cv2.imshow("Camera Test", frame)
            if cv2.waitKey(1) & 0xFF == ord("q"):
                break
    finally:
        camera.release()
        cv2.destroyAllWindows()


if __name__ == "__main__":
    main()
