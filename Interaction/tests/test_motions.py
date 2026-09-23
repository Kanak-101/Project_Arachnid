from __future__ import annotations

from arachnid_interaction.behavior.motions import (
    MotionConfig,
    create_dance,
    create_leg_wave,
    create_shake,
    dance,
    leg_wave,
    shake,
)
from arachnid_interaction.commands import Command


def test_leg_wave_duration_is_6_seconds():
    config = MotionConfig(leg_wave_duration_s=6.0, wave_leg=1)
    cmd = create_leg_wave(config)
    assert cmd.command is Command.LEG_WAVE
    assert cmd.duration_s == 6.0
    assert cmd.parameters["leg"] == 1
    assert cmd.as_dict() == {
        "command": "LEG_WAVE",
        "duration_s": 6.0,
        "parameters": {"leg": 1},
    }


def test_shake_duration_is_6_seconds():
    config = MotionConfig(shake_duration_s=6.0)
    cmd = create_shake(config)
    assert cmd.command is Command.SHAKE
    assert cmd.duration_s == 6.0
    assert cmd.parameters["tripod_a"] == [1, 3, 5]
    assert cmd.parameters["tripod_b"] == [2, 4, 6]


def test_dance_duration_is_8_seconds():
    config = MotionConfig(dance_duration_s=8.0)
    cmd = create_dance(config)
    assert cmd.command is Command.DANCE
    assert cmd.duration_s == 8.0
    assert "tripod_a" in cmd.parameters
    assert "tripod_b" in cmd.parameters


def test_motion_durations_configurable_between_5_and_10_seconds():
    config = MotionConfig(
        forward_duration_s=5.0,
        backward_duration_s=7.0,
        turn_left_duration_s=5.5,
        turn_right_duration_s=5.5,
        leg_wave_duration_s=6.0,
        shake_duration_s=6.0,
        dance_duration_s=8.0,
    )
    for dur in [
        config.forward_duration_s,
        config.backward_duration_s,
        config.turn_left_duration_s,
        config.turn_right_duration_s,
        config.leg_wave_duration_s,
        config.shake_duration_s,
        config.dance_duration_s,
    ]:
        assert 5.0 <= dur <= 10.0


def test_motion_sequence_wrappers():
    assert leg_wave()[0].command is Command.LEG_WAVE
    assert shake()[0].command is Command.SHAKE
    assert dance()[0].command is Command.DANCE
