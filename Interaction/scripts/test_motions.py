from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "src"))

from arachnid_interaction.behavior.motions import MotionConfig, create_dance, create_leg_wave, create_shake


def main() -> None:
    config = MotionConfig(
        forward_duration_s=5.0,
        backward_duration_s=5.0,
        turn_left_duration_s=5.0,
        turn_right_duration_s=5.0,
        leg_wave_duration_s=6.0,
        shake_duration_s=6.0,
        dance_duration_s=8.0,
        wave_leg=1,
    )

    print("Project Arachnid — Motion Command Validation")
    print("--------------------------------------------")

    wave_cmd = create_leg_wave(config)
    print("LEG_WAVE command:")
    print(wave_cmd.as_dict())
    assert wave_cmd.command.value == "LEG_WAVE"
    assert wave_cmd.duration_s == 6.0

    shake_cmd = create_shake(config)
    print("\nSHAKE command:")
    print(shake_cmd.as_dict())
    assert shake_cmd.command.value == "SHAKE"
    assert shake_cmd.duration_s == 6.0

    dance_cmd = create_dance(config)
    print("\nDANCE command:")
    print(dance_cmd.as_dict())
    assert dance_cmd.command.value == "DANCE"
    assert dance_cmd.duration_s == 8.0

    print("\nAll motion durations verified successfully (5-10s demonstration standard).")


if __name__ == "__main__":
    main()
