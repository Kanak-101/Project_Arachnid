from __future__ import annotations

from dataclasses import dataclass


@dataclass(frozen=True)
class BoundingBox:
    x1: int
    y1: int
    x2: int
    y2: int

    @property
    def width(self) -> int:
        return max(0, self.x2 - self.x1)

    @property
    def height(self) -> int:
        return max(0, self.y2 - self.y1)

    @property
    def area(self) -> int:
        return self.width * self.height


@dataclass
class Person:
    track_id: int
    bbox: BoundingBox
    confidence: float

    @property
    def center_x(self) -> float:
        return (self.bbox.x1 + self.bbox.x2) / 2.0

    @property
    def center_y(self) -> float:
        return (self.bbox.y1 + self.bbox.y2) / 2.0
