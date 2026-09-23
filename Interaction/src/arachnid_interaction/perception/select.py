from __future__ import annotations

import time
from typing import Dict, List, Optional, Set

from .types import Person


def select_target(
    people: List[Person],
    image_center_x: float,
    lidar_associated_ids: Optional[Set[int]] = None,
    candidate_distances: Optional[Dict[int, float]] = None,
) -> Optional[int]:
    """Deterministically select one person target from candidates.

    Deterministic criteria:
    1. Valid LiDAR association (prioritize candidates confirmed by LiDAR).
    2. Closest usable candidate distance (if LiDAR distances available).
    3. Center proximity to optical axis (horizontal alignment).
    4. Bounding box area (larger = closer in camera view).
    5. Detection confidence score.
    6. Lower track ID for deterministic tie-breaking.
    """
    if not people:
        return None

    def sort_key(p: Person):
        # LiDAR association: True (1) is better than False (0)
        lidar_rank = 0
        if lidar_associated_ids is not None:
            lidar_rank = 0 if p.track_id in lidar_associated_ids else 1

        # Distance: closer is better
        dist_val = 999.0
        if candidate_distances is not None and p.track_id in candidate_distances:
            dist_val = candidate_distances[p.track_id]

        center_offset = abs(p.center_x - image_center_x)
        area_inv = -p.bbox.area
        conf_inv = -p.confidence

        return (lidar_rank, dist_val, center_offset, area_inv, conf_inv, p.track_id)

    selected = min(people, key=sort_key)
    return selected.track_id


class TargetSelector:
    """Maintains a single target lock across multiple frames.

    Once locked, other detected people are ignored. The target lock is maintained
    until the target is lost for greater than target_timeout_s, becomes invalid,
    or is explicitly cleared.
    """

    def __init__(self, target_timeout_s: float = 3.0):
        self.target_timeout_s = float(target_timeout_s)
        self.target_id: Optional[int] = None
        self.last_seen: float = 0.0

    @property
    def is_locked(self) -> bool:
        return self.target_id is not None

    def clear(self) -> None:
        """Release the active target lock."""
        self.target_id = None
        self.last_seen = 0.0

    def lock(self, target_id: int, now: Optional[float] = None) -> None:
        """Explicitly lock onto a specific target."""
        self.target_id = target_id
        self.last_seen = time.monotonic() if now is None else now

    def update(
        self,
        people: List[Person],
        image_center_x: float,
        now: Optional[float] = None,
        lidar_associated_ids: Optional[Set[int]] = None,
        candidate_distances: Optional[Dict[int, float]] = None,
    ) -> Optional[int]:
        """Update target lock given the current frame's detected people.

        If a target is already locked:
        - If still present, update last_seen and retain lock.
        - If missing, check if timeout expired. If expired, release lock.
        If no target is locked:
        - Select one candidate using deterministic criteria and lock it.
        """
        current_time = time.monotonic() if now is None else now

        if self.target_id is not None:
            # Check if locked target is present in current detections
            matched = any(p.track_id == self.target_id for p in people)
            if matched:
                self.last_seen = current_time
                return self.target_id

            # Target missing: check timeout
            if current_time - self.last_seen > self.target_timeout_s:
                self.clear()
            else:
                return self.target_id

        # No target locked (or just timed out)
        new_target = select_target(
            people,
            image_center_x=image_center_x,
            lidar_associated_ids=lidar_associated_ids,
            candidate_distances=candidate_distances,
        )
        if new_target is not None:
            self.target_id = new_target
            self.last_seen = current_time

        return self.target_id


__all__ = ["select_target", "TargetSelector"]

