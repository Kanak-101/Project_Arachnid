from __future__ import annotations

from arachnid_interaction.commands import Command
from arachnid_interaction.navigation.approach import ApproachController
from arachnid_interaction.perception.types import BoundingBox, Person


def person(cx: float = 640.0) -> Person:
    return Person(1, BoundingBox(int(cx - 40), 100, int(cx + 40), 300), 0.9)


def test_turn_left():
    controller = ApproachController(horizontal_tolerance_px=30, turn_left_duration_s=5.0)
    decision = controller.decide(person(300), 640, 2.0)
    assert decision.command.command is Command.TURN_LEFT
    assert decision.command.duration_s == 5.0


def test_turn_right():
    controller = ApproachController(horizontal_tolerance_px=30, turn_right_duration_s=5.0)
    decision = controller.decide(person(900), 640, 2.0)
    assert decision.command.command is Command.TURN_RIGHT
    assert decision.command.duration_s == 5.0


def test_forward_when_far():
    controller = ApproachController(maximum_distance_m=1.70, forward_duration_s=5.0)
    decision = controller.decide(person(640), 640, 2.5)
    assert decision.command.command is Command.FORWARD
    assert decision.command.duration_s == 5.0


def test_backward_when_too_close():
    controller = ApproachController(minimum_distance_m=1.30, backward_duration_s=5.0)
    decision = controller.decide(person(640), 640, 1.0)
    assert decision.command.command is Command.BACKWARD
    assert decision.command.duration_s == 5.0


def test_stop_when_centered_and_interaction_distance():
    controller = ApproachController(minimum_distance_m=1.30, maximum_distance_m=1.70)
    decision = controller.decide(person(640), 640, 1.50)
    assert decision.command.command is Command.STOP
    assert decision.command.duration_s == 0.0


def test_emergency_stop():
    controller = ApproachController(emergency_stop_m=0.45)
    decision = controller.decide(person(640), 640, 0.30)
    assert decision.command.command is Command.STOP
    assert decision.command.duration_s == 0.0
    assert decision.command.parameters.get("reason") == "emergency_distance"
