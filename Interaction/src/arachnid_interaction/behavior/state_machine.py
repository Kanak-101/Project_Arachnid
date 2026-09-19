from __future__ import annotations

import time
from enum import Enum
from typing import List, Optional

from ..commands import Command, MotionCommand
from ..control.transport import CommandSink
from ..navigation.approach import ApproachController
from ..perception.hand_wave import Gesture
from ..perception.types import Person
from .motions import MotionConfig, create_dance, create_leg_wave, create_shake


class State(str, Enum):
    SEARCHING = "SEARCHING"
    APPROACHING = "APPROACHING"
    INTERACTING = "INTERACTING"


class InteractionStateMachine:
    """High-level behavior state machine.

    States:
    - SEARCHING: Scanning environment for human candidates.
    - APPROACHING: Driving towards and aligning with locked target (5-10s motions).
    - INTERACTING: Target reached; arrival shake performed; responds to target hand waves.
    """

    def __init__(
        self,
        sink: CommandSink,
        approach: ApproachController,
        motion: MotionConfig,
        target_timeout_s: float = 3.0,
        gesture_cooldown_s: float = 2.0,
    ):
        self.sink = sink
        self.approach = approach
        self.motion = motion
        self.target_timeout_s = float(target_timeout_s)
        self.gesture_cooldown_s = float(gesture_cooldown_s)

        self.state = State.SEARCHING
        self.target_id: Optional[int] = None
        self.last_target_seen = 0.0
        self.last_gesture = 0.0
        self._arrival_shake_done = False

    def set_target(self, target_id: int) -> None:
        """Lock onto a confirmed human target."""
        if self.target_id == target_id and self.state is not State.SEARCHING:
            return
        self.target_id = target_id
        self.state = State.APPROACHING
        self._arrival_shake_done = False
        self.last_target_seen = time.monotonic()

    def clear_target(self) -> None:
        """Release target lock, stop robot, and return to SEARCHING."""
        self.sink.stop()
        self.target_id = None
        self.state = State.SEARCHING
        self._arrival_shake_done = False

    def update(
        self,
        people: List[Person],
        image_center_x: float,
        distance_m: Optional[float] = None,
        gesture: Gesture = Gesture.NONE,
        gesture_person_id: Optional[int] = None,
    ) -> None:
        """Process perception updates and step the interaction state machine."""
        now = time.monotonic()

        # In SEARCHING state, robot is waiting or sweeping for targets
        if self.target_id is None:
            if self.state is not State.SEARCHING:
                self.state = State.SEARCHING
            return

        # Locate the locked target among current detections
        target = next((p for p in people if p.track_id == self.target_id), None)
        if target is None:
            if now - self.last_target_seen > self.target_timeout_s:
                self.clear_target()
            return

        # Target is visible: update last seen timestamp
        self.last_target_seen = now

        if self.state is State.APPROACHING:
            decision = self.approach.decide(target, image_center_x, distance_m)
            self.sink.send(decision.command)

            # Check if target is within interaction distance and aligned
            x_error = abs(target.center_x - image_center_x)
            arrived = (
                distance_m is not None
                and self.approach.minimum_distance_m <= distance_m <= self.approach.maximum_distance_m
                and x_error <= self.approach.horizontal_tolerance_px
            )

            if arrived:
                self.state = State.INTERACTING
                if not self._arrival_shake_done:
                    # Immediate stop followed by 6s arrival shake
                    self.sink.send(
                        MotionCommand(Command.STOP, duration_s=0.0, parameters={"reason": "arrived"})
                    )
                    self.sink.send(create_shake(self.motion))
                    self._arrival_shake_done = True
            return

        if self.state is State.INTERACTING:
            # Maintain stationary stance
            self.sink.send(
                MotionCommand(Command.STOP, duration_s=0.0, parameters={"reason": "interaction_idle"})
            )

            # Only the locked target person is allowed to trigger gestures
            valid_person = (
                gesture_person_id is None or gesture_person_id == self.target_id
            )
            if (
                valid_person
                and gesture is Gesture.WAVE
                and now - self.last_gesture >= self.gesture_cooldown_s
            ):
                self.sink.send(create_leg_wave(self.motion))
                self.last_gesture = now

    def trigger_dance(self) -> None:
        """Trigger manual six-leg dance (8s)."""
        self.sink.stop()
        self.sink.send(create_dance(self.motion))

    def trigger_shake(self) -> None:
        """Trigger manual whole-body shake (6s)."""
        self.sink.stop()
        self.sink.send(create_shake(self.motion))

    def trigger_leg_wave(self) -> None:
        """Trigger manual one-leg wave (6s)."""
        self.sink.stop()
        self.sink.send(create_leg_wave(self.motion))


__all__ = ["State", "InteractionStateMachine"]
