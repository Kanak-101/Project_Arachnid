from __future__ import annotations

from dataclasses import dataclass
from typing import Dict, List, Optional, Set, Tuple

from ..perception.types import Person
from .lidar import LidarCandidate


@dataclass(frozen=True)
class FusedDetection:
    """Fused detection linking camera visual evidence with LiDAR spatial metrics."""
    person: Person
    bearing_deg: float
    distance_m: Optional[float] = None
    lidar_associated: bool = False


def camera_x_to_bearing(center_x: float, image_center_x: float, horizontal_fov_deg: float) -> float:
    """Convert horizontal pixel coordinate to relative bearing in degrees.

    0 deg is directly along optical axis (center_x == image_center_x).
    Negative is left, positive is right.
    """
    if image_center_x <= 0:
        return 0.0
    return ((center_x - image_center_x) / image_center_x) * (horizontal_fov_deg / 2.0)


def normalize_angle_deg(angle: float) -> float:
    """Normalize angle to [-180, 180) degrees."""
    return (angle + 180.0) % 360.0 - 180.0


def associate_camera_and_lidar(
    people: List[Person],
    candidates: List[LidarCandidate],
    image_center_x: float,
    horizontal_fov_deg: float = 62.0,
    sector_tolerance_deg: float = 8.0,
) -> Tuple[List[FusedDetection], Set[int], Dict[int, float]]:
    """Associate camera-detected people with spatial LiDAR candidates.

    Returns:
    - List of FusedDetection objects.
    - Set of person track_ids that have verified LiDAR associations.
    - Dict of person track_id -> distance_m.
    """
    fused: List[FusedDetection] = []
    associated_ids: Set[int] = set()
    distances: Dict[int, float] = {}

    used_candidates: Set[int] = set()

    for person in people:
        bearing = camera_x_to_bearing(person.center_x, image_center_x, horizontal_fov_deg)

        best_cand_idx: Optional[int] = None
        best_diff = sector_tolerance_deg
        best_distance: Optional[float] = None

        for idx, cand in enumerate(candidates):
            if idx in used_candidates:
                continue
            # Compare candidate bearing (normalized to [-180, 180]) with camera bearing
            cand_norm = normalize_angle_deg(cand.bearing_deg)
            diff = abs(normalize_angle_deg(cand_norm - bearing))
            if diff <= best_diff:
                best_diff = diff
                best_cand_idx = idx
                best_distance = cand.distance_m

        if best_cand_idx is not None and best_distance is not None:
            used_candidates.add(best_cand_idx)
            associated_ids.add(person.track_id)
            distances[person.track_id] = best_distance
            fused.append(
                FusedDetection(
                    person=person,
                    bearing_deg=round(bearing, 1),
                    distance_m=best_distance,
                    lidar_associated=True,
                )
            )
        else:
            fused.append(
                FusedDetection(
                    person=person,
                    bearing_deg=round(bearing, 1),
                    distance_m=None,
                    lidar_associated=False,
                )
            )

    return fused, associated_ids, distances


__all__ = [
    "FusedDetection",
    "camera_x_to_bearing",
    "normalize_angle_deg",
    "associate_camera_and_lidar",
]

