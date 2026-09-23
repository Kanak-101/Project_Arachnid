from __future__ import annotations

from dataclasses import dataclass, field
from typing import List

from ..commands import Command, MotionCommand


@dataclass(frozen=True)
class MotionConfig:
    """Durations and parameters for high-level Project Arachnid movements.

    All non-stop movement durations must be between 5.0 and 10.0 seconds.
    """
    forward_duration_s: float = 5.0
    backward_duration_s: float = 5.0
    turn_left_duration_s: float = 5.0
    turn_right_duration_s: float = 5.0
    leg_wave_duration_s: float = 6.0
    shake_duration_s: float = 6.0
    dance_duration_s: float = 8.0

    wave_leg: int = 1
    tripod_a: List[int] = field(default_factory=lambda: [1, 3, 5])
    tripod_b: List[int] = field(default_factory=lambda: [2, 4, 6])


def create_leg_wave(config: MotionConfig | None = None) -> MotionCommand:
    """Produce a high-level LEG_WAVE command lasting 6 seconds."""
    cfg = config or MotionConfig()
    return MotionCommand(
        command=Command.LEG_WAVE,
        duration_s=cfg.leg_wave_duration_s,
        parameters={"leg": cfg.wave_leg},
    )


def create_shake(config: MotionConfig | None = None) -> MotionCommand:
    """Produce a high-level whole-body SHAKE command lasting 6 seconds."""
    cfg = config or MotionConfig()
    return MotionCommand(
        command=Command.SHAKE,
        duration_s=cfg.shake_duration_s,
        parameters={"tripod_a": list(cfg.tripod_a), "tripod_b": list(cfg.tripod_b)},
    )


def create_dance(config: MotionConfig | None = None) -> MotionCommand:
    """Produce a high-level six-leg DANCE command lasting 8 seconds."""
    cfg = config or MotionConfig()
    return MotionCommand(
        command=Command.DANCE,
        duration_s=cfg.dance_duration_s,
        parameters={"tripod_a": list(cfg.tripod_a), "tripod_b": list(cfg.tripod_b)},
    )


def leg_wave(config: MotionConfig | None = None) -> List[MotionCommand]:
    """Emit high-level LEG_WAVE sequence."""
    return [create_leg_wave(config)]


def shake(config: MotionConfig | None = None) -> List[MotionCommand]:
    """Emit high-level whole-body SHAKE sequence."""
    return [create_shake(config)]


def dance(config: MotionConfig | None = None) -> List[MotionCommand]:
    """Emit high-level six-leg DANCE sequence."""
    return [create_dance(config)]


__all__ = [
    "MotionConfig",
    "create_leg_wave",
    "create_shake",
    "create_dance",
    "leg_wave",
    "shake",
    "dance",
]
