from __future__ import annotations

import json
import socket
import sys
import time
from abc import ABC, abstractmethod
from typing import Any, Dict, List, Optional

from ..commands import Command, MotionCommand


class CommandEncoder:
    """Serializes MotionCommand objects into JSON lines."""

    @staticmethod
    def encode(command: MotionCommand) -> bytes:
        payload = json.dumps(command.as_dict(), separators=(",", ":"))
        return f"{payload}\n".encode("utf-8")


class CommandSink(ABC):
    """Abstract interface for command transport sinks."""

    @abstractmethod
    def send(self, command: MotionCommand) -> None:
        raise NotImplementedError

    def stop(self) -> None:
        self.send(MotionCommand(Command.STOP, duration_s=0.0, parameters={"reason": "forced_stop"}))

    def close(self) -> None:
        pass


class ConsoleTransport(CommandSink):
    """Prints motion commands to console (standard output) for local development and simulation."""

    def __init__(self):
        self.history: List[Dict[str, Any]] = []

    def send(self, command: MotionCommand) -> None:
        data = command.as_dict()
        self.history.append(data)
        encoded = json.dumps(data)
        sys.stdout.write(f"[TRANSPORT:CONSOLE] {encoded}\n")
        sys.stdout.flush()


class ArachnidServerTransport(CommandSink):
    """Direct TCP transport for Project Arachnid's Controller (arachnid_server.py).

    Translates high-level interaction commands to the real Project Arachnid controller protocol:
      - FORWARD    -> {"cmd": "WALK", "dx": 0.030, "dy": 0.0, "dyaw": 0.0}
      - BACKWARD   -> {"cmd": "WALK", "dx": -0.030, "dy": 0.0, "dyaw": 0.0}
      - TURN_LEFT  -> {"cmd": "WALK", "dx": 0.0, "dy": 0.0, "dyaw": 0.20}
      - TURN_RIGHT -> {"cmd": "WALK", "dx": 0.0, "dy": 0.0, "dyaw": -0.20}
      - STOP       -> {"cmd": "STAND"}
      - LEG_WAVE   -> {"cmd": "LEG", "leg": 1, "dx": 0.0, "dy": 0.0, "dz": -0.030}
      - SHAKE      -> {"cmd": "SHAKE"} (or standing pulse)
      - DANCE      -> {"cmd": "DANCE"} (forwarded for controller gait choreography)
    """

    def __init__(self, host: str = "192.168.0.100", port: int = 5000):
        self.host = host
        self.port = int(port)
        self._socket: Optional[socket.socket] = None
        self._connect()

    def _connect(self) -> None:
        try:
            s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            s.settimeout(1.0)
            s.connect((self.host, self.port))
            self._socket = s
        except Exception:
            self._socket = None

    def _translate_to_controller_payload(self, command: MotionCommand) -> Dict[str, Any]:
        cmd = command.command
        if cmd is Command.FORWARD:
            return {"cmd": "WALK", "dx": 0.030, "dy": 0.0, "dyaw": 0.0}
        elif cmd is Command.BACKWARD:
            return {"cmd": "WALK", "dx": -0.030, "dy": 0.0, "dyaw": 0.0}
        elif cmd is Command.TURN_LEFT:
            return {"cmd": "WALK", "dx": 0.0, "dy": 0.0, "dyaw": 0.20}
        elif cmd is Command.TURN_RIGHT:
            return {"cmd": "WALK", "dx": 0.0, "dy": 0.0, "dyaw": -0.20}
        elif cmd is Command.STOP:
            return {"cmd": "STAND"}
        elif cmd is Command.LEG_WAVE:
            leg = int(command.parameters.get("leg", 1))
            return {"cmd": "LEG", "leg": leg, "dx": 0.0, "dy": 0.0, "dz": -0.030}
        elif cmd is Command.SHAKE:
            return {"cmd": "SHAKE", "duration_s": command.duration_s}
        elif cmd is Command.DANCE:
            return {"cmd": "DANCE", "duration_s": command.duration_s}
        return {"cmd": cmd.value}

    def send(self, command: MotionCommand) -> None:
        payload = self._translate_to_controller_payload(command)
        line = json.dumps(payload) + "\n"
        if self._socket is None:
            self._connect()
        if self._socket is not None:
            try:
                self._socket.sendall(line.encode("utf-8"))
            except Exception:
                self._socket = None

    def close(self) -> None:
        if self._socket is not None:
            try:
                self._socket.close()
            except Exception:
                pass
            self._socket = None


class SerialTransport(CommandSink):
    """Sends JSON-line commands over USB serial to a microcontroller/controller."""

    def __init__(self, port: str = "COM4", baudrate: int = 115200):
        try:
            import serial
            self._serial = serial.Serial(port, baudrate=baudrate, timeout=0.1)
        except Exception as exc:
            self._serial = None

    def send(self, command: MotionCommand) -> None:
        if self._serial is not None:
            try:
                payload = CommandEncoder.encode(command)
                self._serial.write(payload)
                self._serial.flush()
            except Exception:
                pass

    def close(self) -> None:
        if self._serial is not None:
            try:
                self._serial.close()
            except Exception:
                pass
            self._serial = None


class TcpTransport(CommandSink):
    """Sends raw JSON-line MotionCommands over TCP socket."""

    def __init__(self, host: str = "127.0.0.1", port: int = 8765):
        self.host = host
        self.port = port
        self._socket: Optional[socket.socket] = None
        self._connect()

    def _connect(self) -> None:
        try:
            self._socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            self._socket.connect((self.host, self.port))
        except Exception:
            self._socket = None

    def send(self, command: MotionCommand) -> None:
        if self._socket is None:
            self._connect()
        if self._socket is not None:
            try:
                self._socket.sendall(CommandEncoder.encode(command))
            except Exception:
                self._socket = None

    def close(self) -> None:
        if self._socket is not None:
            try:
                self._socket.close()
            except Exception:
                pass
            self._socket = None


class RateLimitedTransport(CommandSink):
    """Prevents flooding identical commands to the transport."""

    def __init__(self, sink: CommandSink, repeat_interval_s: float = 0.12):
        self.sink = sink
        self.repeat_interval_s = float(repeat_interval_s)
        self._last_command: Optional[MotionCommand] = None
        self._last_sent_at = 0.0

    def send(self, command: MotionCommand) -> None:
        now = time.monotonic()
        is_same = self._last_command == command
        if not is_same or (now - self._last_sent_at >= self.repeat_interval_s):
            self.sink.send(command)
            self._last_command = command
            self._last_sent_at = now

    def stop(self) -> None:
        self.sink.stop()
        self._last_command = None

    def close(self) -> None:
        self.sink.close()


def create_transport(config: Dict[str, Any]) -> CommandSink:
    """Factory to create configured transport (console, arachnid, serial, tcp)."""
    transport_type = str(config.get("type", "console")).lower()

    if transport_type in ("arachnid", "rpi", "robot"):
        host = str(config.get("rpi_host", "192.168.0.100"))
        port = int(config.get("rpi_port", 5000))
        sink: CommandSink = ArachnidServerTransport(host=host, port=port)
    elif transport_type == "serial":
        port_name = str(config.get("serial_port", "COM4"))
        baudrate = int(config.get("serial_baudrate", 115200))
        sink = SerialTransport(port=port_name, baudrate=baudrate)
    elif transport_type == "tcp":
        host = str(config.get("tcp_host", "127.0.0.1"))
        port_num = int(config.get("tcp_port", 8765))
        sink = TcpTransport(host=host, port=port_num)
    else:
        sink = ConsoleTransport()

    interval = float(config.get("repeat_interval_s", 0.0))
    if interval > 0:
        return RateLimitedTransport(sink, repeat_interval_s=interval)
    return sink


__all__ = [
    "CommandEncoder",
    "CommandSink",
    "ConsoleTransport",
    "ArachnidServerTransport",
    "SerialTransport",
    "TcpTransport",
    "RateLimitedTransport",
    "create_transport",
]
