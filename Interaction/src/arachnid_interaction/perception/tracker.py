from __future__ import annotations

from .types import BoundingBox, Person


class IoUTracker:
    """Lightweight frame-to-frame tracker for a local, small-room demo."""

    def __init__(self, iou_threshold: float = 0.30, max_age_frames: int = 20):
        self.iou_threshold = iou_threshold
        self.max_age_frames = max_age_frames
        self._next_id = 1
        self._tracks: dict[int, tuple[BoundingBox, int]] = {}

    @staticmethod
    def _iou(a: BoundingBox, b: BoundingBox) -> float:
        ix1 = max(a.x1, b.x1)
        iy1 = max(a.y1, b.y1)
        ix2 = min(a.x2, b.x2)
        iy2 = min(a.y2, b.y2)
        iw = max(0, ix2 - ix1)
        ih = max(0, iy2 - iy1)
        intersection = iw * ih
        if intersection <= 0:
            return 0.0
        union = a.width * a.height + b.width * b.height - intersection
        return intersection / union if union else 0.0

    def update(self, detections: list[Person]) -> list[Person]:
        candidates = list(self._tracks.items())
        used_tracks: set[int] = set()
        updated: dict[int, tuple[BoundingBox, int]] = {}

        for detection in sorted(detections, key=lambda p: (-p.confidence, p.bbox.area)):
            best_id = None
            best_score = self.iou_threshold
            for track_id, (bbox, _age) in candidates:
                if track_id in used_tracks:
                    continue
                score = self._iou(detection.bbox, bbox)
                if score >= best_score:
                    best_score = score
                    best_id = track_id
            if best_id is None:
                best_id = self._next_id
                self._next_id += 1
            used_tracks.add(best_id)
            detection.track_id = best_id
            updated[best_id] = (detection.bbox, 0)

        for track_id, (bbox, age) in self._tracks.items():
            if track_id not in updated and age + 1 <= self.max_age_frames:
                updated[track_id] = (bbox, age + 1)

        self._tracks = updated
        return detections
