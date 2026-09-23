from __future__ import annotations

from dataclasses import dataclass, field
from enum import Enum
from typing import Any


class Command(str, Enum):
    STOP = "STOP"
    FORWARD = "FORWARD"
    BACKWARD = "BACKWARD"
    TURN_LEFT = "TURN_LEFT"
    TURN_RIGHT = "TURN_RIGHT"
    LEG_WAVE = "LEG_WAVE"
    SHAKE = "SHAKE"
    DANCE = "DANCE"


@dataclass(frozen=True)
class MotionCommand:
    command: Command = Command.STOP
    duration_s: float = 0.0
    parameters: dict[str, Any] = field(default_factory=dict)
    name: str | None = None

    def __post_init__(self) -> None:
        cmd = self.command
        if self.name is not None:
            if isinstance(self.name, Command):
                cmd = self.name
            else:
                cmd = Command(str(self.name))
        elif isinstance(cmd, str) and not isinstance(cmd, Command):
            cmd = Command(cmd)
        object.__setattr__(self, "command", cmd)
        object.__setattr__(self, "duration_s", float(self.duration_s))

    def as_dict(self) -> dict[str, Any]:
        result: dict[str, Any] = {
            "command": self.command.value,
            "duration_s": round(max(0.0, self.duration_s), 3),
        }
        if self.parameters:
            result["parameters"] = self.parameters
        return result

