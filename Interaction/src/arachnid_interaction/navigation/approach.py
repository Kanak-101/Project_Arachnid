from __future__ import annotations

from dataclasses import dataclass
from typing import Optional

from ..commands import Command, MotionCommand
from ..perception.types import Person


@dataclass(frozen=True)
class ApproachDecision:
    command: MotionCommand


class ApproachController:
    """Computes navigation decisions to approach and align with a selected target.

    Implements:
    - Alignment: TURN_LEFT / TURN_RIGHT (5-10s duration)
    - Distance: FORWARD / BACKWARD (5-10s duration)
    - Interaction zone: STOP (immediate, 0.0s duration)
    - Safety: Emergency stop on close proximity violation.
    """

    def __init__(
        self,
        horizontal_tolerance_px: int = 80,
        center_tolerance_px: Optional[int] = None,
        minimum_distance_m: float = 1.30,
        interaction_min_m: Optional[float] = None,
        maximum_distance_m: float = 1.70,
        interaction_max_m: Optional[float] = None,
        preferred_distance_m: float = 1.50,
        emergency_stop_m: float = 0.45,
        forward_duration_s: float = 5.0,
        backward_duration_s: float = 5.0,
        turn_left_duration_s: float = 5.0,
        turn_right_duration_s: float = 5.0,
        turn_duration_s: Optional[float] = None,
    ):
        self.horizontal_tolerance_px = int(
            center_tolerance_px if center_tolerance_px is not None else horizontal_tolerance_px
        )
        self.minimum_distance_m = float(
            interaction_min_m if interaction_min_m is not None else minimum_distance_m
        )
        self.maximum_distance_m = float(
            interaction_max_m if interaction_max_m is not None else maximum_distance_m
        )
        self.preferred_distance_m = float(preferred_distance_m)
        self.emergency_stop_m = float(emergency_stop_m)

        self.forward_duration_s = float(forward_duration_s)
        self.backward_duration_s = float(backward_duration_s)

        t_dur = turn_duration_s if turn_duration_s is not None else 5.0
        self.turn_left_duration_s = float(turn_left_duration_s if turn_duration_s is None else t_dur)
        self.turn_right_duration_s = float(turn_right_duration_s if turn_duration_s is None else t_dur)

    # Aliases for backward compatibility
    @property
    def interaction_min_m(self) -> float:
        return self.minimum_distance_m

    @property
    def interaction_max_m(self) -> float:
        return self.maximum_distance_m

    def decide(
        self,
        target: Person,
        image_center_x: float,
        distance_m: Optional[float] = None,
    ) -> ApproachDecision:
        # Safety: Emergency proximity stop
        if distance_m is not None and distance_m <= self.emergency_stop_m:
            return ApproachDecision(
                MotionCommand(
                    command=Command.STOP,
                    duration_s=0.0,
                    parameters={"reason": "emergency_distance", "distance_m": round(distance_m, 3)},
                )
            )

        # Angular alignment check
        x_error = target.center_x - image_center_x
        if x_error < -self.horizontal_tolerance_px:
            return ApproachDecision(
                MotionCommand(
                    command=Command.TURN_LEFT,
                    duration_s=self.turn_left_duration_s,
                    parameters={"target_error_px": round(x_error, 1)},
                )
            )
        if x_error > self.horizontal_tolerance_px:
            return ApproachDecision(
                MotionCommand(
                    command=Command.TURN_RIGHT,
                    duration_s=self.turn_right_duration_s,
                    parameters={"target_error_px": round(x_error, 1)},
                )
            )

        # Distance check
        if distance_m is None:
            return ApproachDecision(
                MotionCommand(
                    command=Command.STOP,
                    duration_s=0.0,
                    parameters={"reason": "no_target_distance"},
                )
            )

        if distance_m > self.maximum_distance_m:
            return ApproachDecision(
                MotionCommand(
                    command=Command.FORWARD,
                    duration_s=self.forward_duration_s,
                    parameters={"distance_m": round(distance_m, 3)},
                )
            )

        if distance_m < self.minimum_distance_m:
            return ApproachDecision(
                MotionCommand(
                    command=Command.BACKWARD,
                    duration_s=self.backward_duration_s,
                    parameters={"distance_m": round(distance_m, 3)},
                )
            )

        # Target is aligned and within interaction range [minimum_distance_m, maximum_distance_m]
        return ApproachDecision(
            MotionCommand(
                command=Command.STOP,
                duration_s=0.0,
                parameters={"reason": "interaction_distance", "distance_m": round(distance_m, 3)},
            )
        )


__all__ = ["ApproachDecision", "ApproachController"]
