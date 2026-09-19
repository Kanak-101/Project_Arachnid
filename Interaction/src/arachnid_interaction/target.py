from __future__ import annotations

import time
from dataclasses import dataclass
from typing import Optional

from .perception.types import BoundingBox, Person


@dataclass
class Target:
    """Tracked target state maintained across frames."""
    target_id: int
    bounding_box: BoundingBox
    center_x: float
    center_y: float
    last_seen: float
    distance: Optional[float] = None
    bearing: Optional[float] = None
    confidence: float = 1.0

    @classmethod
    def from_person(
        cls,
        person: Person,
        distance: Optional[float] = None,
        bearing: Optional[float] = None,
        timestamp: Optional[float] = None,
    ) -> Target:
        ts = time.monotonic() if timestamp is None else timestamp
        return cls(
            target_id=person.track_id,
            bounding_box=person.bbox,
            center_x=person.center_x,
            center_y=person.center_y,
            last_seen=ts,
            distance=distance,
            bearing=bearing,
            confidence=person.confidence,
        )

    def update_from_person(
        self,
        person: Person,
        distance: Optional[float] = None,
        bearing: Optional[float] = None,
        timestamp: Optional[float] = None,
    ) -> None:
        self.bounding_box = person.bbox
        self.center_x = person.center_x
        self.center_y = person.center_y
        self.confidence = person.confidence
        self.last_seen = time.monotonic() if timestamp is None else timestamp
        if distance is not None:
            self.distance = distance
        if bearing is not None:
            self.bearing = bearing


__all__ = ["BoundingBox", "Person", "Target"]

