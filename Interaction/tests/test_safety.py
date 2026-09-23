from __future__ import annotations

from arachnid_interaction.commands import Command
from arachnid_interaction.control.transport import ConsoleTransport
from arachnid_interaction.navigation.approach import ApproachController
from arachnid_interaction.perception.types import BoundingBox, Person


def make_person(cx: float = 640.0) -> Person:
    return Person(1, BoundingBox(int(cx - 40), 100, int(cx + 40), 300), 0.9)


def test_safety_emergency_stop_triggered_on_proximity():
    controller = ApproachController(emergency_stop_m=0.45)
    # Target within emergency distance (0.35m < 0.45m)
    decision = controller.decide(make_person(640), 640, distance_m=0.35)
    assert decision.command.command is Command.STOP
    assert decision.command.duration_s == 0.0
    assert decision.command.parameters.get("reason") == "emergency_distance"


def test_safety_stop_on_missing_distance():
    controller = ApproachController()
    # Centered target but no distance metric available
    decision = controller.decide(make_person(640), 640, distance_m=None)
    assert decision.command.command is Command.STOP
    assert decision.command.duration_s == 0.0
    assert decision.command.parameters.get("reason") == "no_target_distance"


def test_safety_forced_stop_via_transport():
    sink = ConsoleTransport()
    sink.stop()
    assert len(sink.history) == 1
    assert sink.history[0]["command"] == Command.STOP.value
    assert sink.history[0]["duration_s"] == 0.0

