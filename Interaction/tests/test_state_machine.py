from __future__ import annotations

from arachnid_interaction.behavior.motions import MotionConfig
from arachnid_interaction.behavior.state_machine import InteractionStateMachine, State
from arachnid_interaction.commands import Command
from arachnid_interaction.control.transport import ConsoleTransport
from arachnid_interaction.navigation.approach import ApproachController
from arachnid_interaction.perception.hand_wave import Gesture
from arachnid_interaction.perception.types import BoundingBox, Person


def make_machine():
    sink = ConsoleTransport()
    approach = ApproachController(minimum_distance_m=1.30, maximum_distance_m=1.70)
    motion = MotionConfig(
        leg_wave_duration_s=6.0,
        shake_duration_s=6.0,
        dance_duration_s=8.0,
    )
    machine = InteractionStateMachine(
        sink=sink,
        approach=approach,
        motion=motion,
        target_timeout_s=2.0,
        gesture_cooldown_s=0.0,
    )
    return machine, sink


def make_person(pid: int = 5, cx: float = 640.0) -> Person:
    return Person(pid, BoundingBox(int(cx - 40), 100, int(cx + 40), 300), 0.9)


def test_target_lock_and_arrival_shake():
    machine, sink = make_machine()
    machine.set_target(5)
    assert machine.state is State.APPROACHING

    # Target arrives at interaction distance
    machine.update([make_person(5, 640)], image_center_x=640, distance_m=1.50)
    assert machine.state is State.INTERACTING

    # Verify arrival shake command was issued with 6s duration
    shake_cmds = [item for item in sink.history if item["command"] == Command.SHAKE.value]
    assert len(shake_cmds) >= 1
    assert shake_cmds[0]["duration_s"] == 6.0


def test_wave_from_selected_target_triggers_leg_wave():
    machine, sink = make_machine()
    machine.set_target(5)
    machine.update([make_person(5, 640)], image_center_x=640, distance_m=1.50)
    sink.history.clear()

    # Selected person waves
    machine.update(
        [make_person(5, 640)],
        image_center_x=640,
        distance_m=1.50,
        gesture=Gesture.WAVE,
        gesture_person_id=5,
    )
    wave_cmds = [item for item in sink.history if item["command"] == Command.LEG_WAVE.value]
    assert len(wave_cmds) >= 1
    assert wave_cmds[0]["duration_s"] == 6.0


def test_unselected_person_wave_is_ignored():
    machine, sink = make_machine()
    machine.set_target(5)
    machine.update([make_person(5, 640)], image_center_x=640, distance_m=1.50)
    sink.history.clear()

    # Person 8 waves (not the locked target 5)
    machine.update(
        [make_person(5, 640), make_person(8, 200)],
        image_center_x=640,
        distance_m=1.50,
        gesture=Gesture.WAVE,
        gesture_person_id=8,
    )
    wave_cmds = [item for item in sink.history if item["command"] == Command.LEG_WAVE.value]
    assert len(wave_cmds) == 0


def test_lost_target_returns_to_searching():
    machine, sink = make_machine()
    machine.set_target(5)
    assert machine.state is State.APPROACHING

    # Age last seen beyond timeout
    machine.last_target_seen -= 10.0
    machine.update([], image_center_x=640, distance_m=None)

    assert machine.state is State.SEARCHING
    assert machine.target_id is None
    # Stop command issued upon target loss
    assert sink.history[-1]["command"] == Command.STOP.value


def test_manual_motion_triggers():
    machine, sink = make_machine()

    machine.trigger_dance()
    dance_cmds = [c for c in sink.history if c["command"] == Command.DANCE.value]
    assert len(dance_cmds) == 1
    assert dance_cmds[0]["duration_s"] == 8.0

    machine.trigger_shake()
    shake_cmds = [c for c in sink.history if c["command"] == Command.SHAKE.value]
    assert len(shake_cmds) == 1
    assert shake_cmds[0]["duration_s"] == 6.0

    machine.trigger_leg_wave()
    wave_cmds = [c for c in sink.history if c["command"] == Command.LEG_WAVE.value]
    assert len(wave_cmds) == 1
    assert wave_cmds[0]["duration_s"] == 6.0
