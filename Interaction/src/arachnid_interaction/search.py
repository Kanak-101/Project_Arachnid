from __future__ import annotations

from dataclasses import dataclass
from typing import List, Optional, Tuple

from .commands import Command, MotionCommand
from .navigation.fusion import associate_camera_and_lidar, normalize_angle_deg
from .navigation.lidar import LidarCandidate, LidarReader
from .perception.person_detector import BasePersonDetector
from .perception.types import Person


@dataclass(frozen=True)
class SearchResult:
    """Outcome of spatial search combining LiDAR scan and camera confirmation."""
    confirmed_target_id: Optional[int] = None
    suggested_motion: Optional[MotionCommand] = None
    unconfirmed_candidates: List[LidarCandidate] = None


class SpatialSearcher:
    """Coordinates spatial search using RPLiDAR candidates and camera confirmation.

    Workflow:
    1. RPLiDAR identifies spatial cluster candidates around robot.
    2. Check if any candidate aligns with camera field of view.
    3. OpenCV detector confirms if candidate is human.
    4. If candidate is outside FOV, suggests turn motion to sweep towards it.
    5. Returns confirmed target ID or exploratory sweep.
    """

    def __init__(
        self,
        horizontal_fov_deg: float = 62.0,
        sector_tolerance_deg: float = 12.0,
        turn_duration_s: float = 5.0,
    ):
        self.horizontal_fov_deg = float(horizontal_fov_deg)
        self.sector_tolerance_deg = float(sector_tolerance_deg)
        self.turn_duration_s = float(turn_duration_s)

    def evaluate(
        self,
        candidates: List[LidarCandidate],
        people: List[Person],
        image_center_x: float,
    ) -> SearchResult:
        """Correlate LiDAR candidates with camera people detections."""
        if not candidates and not people:
            return SearchResult(unconfirmed_candidates=[])

        # If camera already sees people, check LiDAR association
        if people:
            _fused, associated_ids, distances = associate_camera_and_lidar(
                people,
                candidates,
                image_center_x,
                self.horizontal_fov_deg,
                self.sector_tolerance_deg,
            )
            # If at least one person has LiDAR confirmation, pick the closest confirmed one
            confirmed_ids = [p.track_id for p in people if p.track_id in associated_ids]
            if confirmed_ids:
                best_id = min(confirmed_ids, key=lambda pid: distances.get(pid, 999.0))
                return SearchResult(confirmed_target_id=best_id, unconfirmed_candidates=candidates)

            # Fallback: person detected by camera even if LiDAR is disabled/unassociated
            return SearchResult(confirmed_target_id=people[0].track_id, unconfirmed_candidates=candidates)

        # Camera sees no people, but LiDAR detected spatial candidates around robot
        half_fov = self.horizontal_fov_deg / 2.0
        for cand in candidates:
            bearing = normalize_angle_deg(cand.bearing_deg)
            # Candidate is outside camera FOV: suggest turning to face it
            if bearing < -half_fov:
                return SearchResult(
                    suggested_motion=MotionCommand(Command.TURN_LEFT, self.turn_duration_s, {"bearing_deg": bearing}),
                    unconfirmed_candidates=candidates,
                )
            if bearing > half_fov:
                return SearchResult(
                    suggested_motion=MotionCommand(Command.TURN_RIGHT, self.turn_duration_s, {"bearing_deg": bearing}),
                    unconfirmed_candidates=candidates,
                )

        return SearchResult(unconfirmed_candidates=candidates)


__all__ = ["SearchResult", "SpatialSearcher"]

