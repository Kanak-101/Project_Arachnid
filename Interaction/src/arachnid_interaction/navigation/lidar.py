from __future__ import annotations

import threading
from collections import deque
from dataclasses import dataclass
from typing import List, Optional, Tuple


@dataclass(frozen=True)
class LidarCandidate:
    """Spatial candidate identified by LiDAR point cluster."""
    bearing_deg: float
    distance_m: float
    point_count: int = 1


class LidarReader:
    """Background RPLIDAR reader and spatial candidate extractor."""

    def __init__(
        self,
        port: str = "COM3",
        baudrate: int = 115200,
        min_range_m: float = 0.4,
        max_range_m: float = 8.0,
    ):
        self.port = port
        self.baudrate = baudrate
        self.min_range_m = float(min_range_m)
        self.max_range_m = float(max_range_m)

        self._driver = None
        self._lock = threading.Lock()
        self._points: deque[Tuple[float, float]] = deque(maxlen=1440)
        self._thread: Optional[threading.Thread] = None
        self._running = False

    def start(self) -> None:
        if self._running:
            return
        try:
            from rplidar import RPLidar
            self._driver = RPLidar(self.port, baudrate=self.baudrate)
        except Exception as exc:
            raise RuntimeError(
                f"Failed to connect to RPLIDAR on {self.port} at {self.baudrate}: {exc}"
            ) from exc

        self._running = True
        self._thread = threading.Thread(target=self._run, daemon=True)
        self._thread.start()

    def stop(self) -> None:
        self._running = False
        if self._thread:
            self._thread.join(timeout=1.0)
            self._thread = None
        if self._driver:
            try:
                self._driver.stop()
                self._driver.disconnect()
            except Exception:
                pass
            self._driver = None

    def _run(self) -> None:
        try:
            for scan in self._driver.iter_scans(max_buf_meas=500):
                if not self._running:
                    break
                with self._lock:
                    self._points.clear()
                    for _quality, angle, distance_mm in scan:
                        distance = float(distance_mm) / 1000.0
                        if self.min_range_m <= distance <= self.max_range_m:
                            self._points.append((float(angle), distance))
        except Exception:
            pass
        finally:
            self._running = False

    def feed_points(self, points: List[Tuple[float, float]]) -> None:
        """Feed simulated or external scan points (useful for deterministic unit testing)."""
        with self._lock:
            self._points.clear()
            for angle, distance in points:
                if self.min_range_m <= distance <= self.max_range_m:
                    self._points.append((float(angle), float(distance)))

    def distance_at(self, bearing_deg: float, sector_deg: float = 8.0) -> Optional[float]:
        """Query median/percentile distance within an angular sector around bearing_deg."""
        with self._lock:
            points = list(self._points)
        if not points:
            return None

        def angular_error(angle: float) -> float:
            return abs((angle - bearing_deg + 180.0) % 360.0 - 180.0)

        selected = [dist for ang, dist in points if angular_error(ang) <= sector_deg]
        if not selected:
            return None
        selected.sort()
        # Return 25th-percentile for obstacle/human leading edge
        return selected[max(0, len(selected) // 4)]

    def extract_candidates(
        self,
        cluster_angle_thresh_deg: float = 6.0,
        cluster_dist_thresh_m: float = 0.35,
        min_cluster_points: int = 3,
    ) -> List[LidarCandidate]:
        """Group scan points into spatial candidates (clusters).

        Returns spatial candidates characterized by bearing (degrees) and distance (meters).
        """
        with self._lock:
            points = sorted(list(self._points), key=lambda pt: pt[0])

        if not points:
            return []

        clusters: List[List[Tuple[float, float]]] = []
        current_cluster: List[Tuple[float, float]] = [points[0]]

        for i in range(1, len(points)):
            prev_ang, prev_dist = points[i - 1]
            curr_ang, curr_dist = points[i]

            ang_diff = abs((curr_ang - prev_ang + 180.0) % 360.0 - 180.0)
            dist_diff = abs(curr_dist - prev_dist)

            if ang_diff <= cluster_angle_thresh_deg and dist_diff <= cluster_dist_thresh_m:
                current_cluster.append((curr_ang, curr_dist))
            else:
                if len(current_cluster) >= min_cluster_points:
                    clusters.append(current_cluster)
                current_cluster = [(curr_ang, curr_dist)]

        if len(current_cluster) >= min_cluster_points:
            clusters.append(current_cluster)

        candidates: List[LidarCandidate] = []
        for cluster in clusters:
            avg_ang = sum(p[0] for p in cluster) / len(cluster)
            avg_dist = sum(p[1] for p in cluster) / len(cluster)
            candidates.append(
                LidarCandidate(
                    bearing_deg=round(avg_ang, 1),
                    distance_m=round(avg_dist, 3),
                    point_count=len(cluster),
                )
            )

        return candidates


__all__ = ["LidarCandidate", "LidarReader"]
