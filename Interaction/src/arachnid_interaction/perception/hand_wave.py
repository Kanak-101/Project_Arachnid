from __future__ import annotations

from collections import deque
from enum import Enum
from typing import Any, Deque, List, Optional, Tuple

import cv2
import numpy as np

from .types import BoundingBox


class Gesture(str, Enum):
    NONE = "NONE"
    WAVE = "WAVE"


class WaveDetector:
    """Detects multi-frame alternating horizontal hand movements.

    Rejects static raised hands by requiring at least min_direction_changes
    horizontal reversals across a history of frames.
    """

    def __init__(
        self,
        history_frames: int = 8,
        min_range_px: float = 35.0,
        min_direction_changes: int = 2,
        deadband_px: float = 3.0,
    ):
        self.history_frames = int(history_frames)
        self.min_range_px = float(min_range_px)
        self.min_direction_changes = int(min_direction_changes)
        self.deadband_px = float(deadband_px)
        self._history: Deque[Tuple[float, float]] = deque(maxlen=self.history_frames)

    def update(self, point: Optional[Tuple[float, float]]) -> Gesture:
        """Update tracker with wrist/hand coordinate (x, y).

        Returns Gesture.WAVE if sufficient alternating horizontal motion is observed.
        """
        if point is None:
            self.reset()
            return Gesture.NONE

        self._history.append(point)
        if len(self._history) < self.history_frames:
            return Gesture.NONE

        xs = [p[0] for p in self._history]
        span = max(xs) - min(xs)
        if span < self.min_range_px:
            return Gesture.NONE

        directions: List[int] = []
        for prev, cur in zip(xs, xs[1:]):
            delta = cur - prev
            if abs(delta) < self.deadband_px:
                continue
            direction = 1 if delta > 0 else -1
            if not directions or direction != directions[-1]:
                directions.append(direction)

        if len(directions) - 1 >= self.min_direction_changes:
            return Gesture.WAVE

        return Gesture.NONE

    def reset(self) -> None:
        self._history.clear()


class MediaPipeHandAdapter:
    """Extracts wrist/hand landmarks from the selected person's bounding box."""

    def __init__(self, min_detection_confidence: float = 0.5):
        try:
            import mediapipe as mp
            self._mp = mp
            self._hands = mp.solutions.hands.Hands(
                static_image_mode=False,
                max_num_hands=2,
                min_detection_confidence=min_detection_confidence,
                min_tracking_confidence=min_detection_confidence,
            )
            self._available = True
        except (ImportError, Exception):
            self._mp = None
            self._hands = None
            self._available = False

    @property
    def is_available(self) -> bool:
        return self._available

    def wrist_for_box(
        self, frame: np.ndarray, bbox: BoundingBox
    ) -> Optional[Tuple[float, float]]:
        """Find the most prominent hand wrist coordinate inside person crop."""
        if not self._available or self._hands is None:
            return None

        h, w = frame.shape[:2]
        x1, y1 = max(0, bbox.x1), max(0, bbox.y1)
        x2, y2 = min(w, bbox.x2), min(h, bbox.y2)
        if x2 <= x1 or y2 <= y1:
            return None

        crop = frame[y1:y2, x1:x2]
        rgb = cv2.cvtColor(crop, cv2.COLOR_BGR2RGB)
        result = self._hands.process(rgb)

        if not result.multi_hand_landmarks:
            return None

        # Pick highest hand in person box (smallest y landmark)
        hand = min(
            result.multi_hand_landmarks,
            key=lambda item: item.landmark[self._mp.solutions.hands.HandLandmark.WRIST].y,
        )
        wrist = hand.landmark[self._mp.solutions.hands.HandLandmark.WRIST]
        return (x1 + wrist.x * (x2 - x1), y1 + wrist.y * (y2 - y1))

    def close(self) -> None:
        if self._hands is not None:
            self._hands.close()


__all__ = ["Gesture", "WaveDetector", "MediaPipeHandAdapter"]

