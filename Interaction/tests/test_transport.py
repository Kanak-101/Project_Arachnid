from __future__ import annotations

from arachnid_interaction.commands import Command, MotionCommand
from arachnid_interaction.control.transport import (
    ArachnidServerTransport,
    CommandEncoder,
    ConsoleTransport,
    RateLimitedTransport,
    create_transport,
)


def test_command_encoding_is_json_lines():
    encoded = CommandEncoder.encode(MotionCommand(Command.STOP, duration_s=0.0))
    assert encoded.endswith(b"\n")
    assert b'"command":"STOP"' in encoded
    assert b'"duration_s":0.0' in encoded


def test_console_sink_retains_history():
    sink = ConsoleTransport()
    sink.send(MotionCommand(Command.DANCE, duration_s=8.0, parameters={"test": True}))
    assert len(sink.history) == 1
    assert sink.history[-1]["command"] == "DANCE"
    assert sink.history[-1]["duration_s"] == 8.0


def test_rate_limiter_deduplicates_repeated_command():
    inner = ConsoleTransport()
    sink = RateLimitedTransport(inner, repeat_interval_s=60.0)
    command = MotionCommand(Command.FORWARD, duration_s=5.0)
    sink.send(command)
    sink.send(command)
    assert len(inner.history) == 1


def test_create_transport_factory():
    console_sink = create_transport({"type": "console", "repeat_interval_s": 0.0})
    assert isinstance(console_sink, ConsoleTransport)


def test_arachnid_server_transport_translation():
    # Mock transport without active network connection
    transport = ArachnidServerTransport.__new__(ArachnidServerTransport)
    transport._socket = None

    fwd_payload = transport._translate_to_controller_payload(
        MotionCommand(Command.FORWARD, duration_s=5.0)
    )
    assert fwd_payload["cmd"] == "WALK"
    assert fwd_payload["dx"] > 0.0

    back_payload = transport._translate_to_controller_payload(
        MotionCommand(Command.BACKWARD, duration_s=5.0)
    )
    assert back_payload["cmd"] == "WALK"
    assert back_payload["dx"] < 0.0

    turn_payload = transport._translate_to_controller_payload(
        MotionCommand(Command.TURN_LEFT, duration_s=5.0)
    )
    assert turn_payload["cmd"] == "WALK"
    assert turn_payload["dyaw"] > 0.0

    stop_payload = transport._translate_to_controller_payload(
        MotionCommand(Command.STOP, duration_s=0.0)
    )
    assert stop_payload["cmd"] == "STAND"

    wave_payload = transport._translate_to_controller_payload(
        MotionCommand(Command.LEG_WAVE, duration_s=6.0, parameters={"leg": 1})
    )
    assert wave_payload["cmd"] == "LEG"
    assert wave_payload["leg"] == 1
    assert wave_payload["dz"] < 0.0
