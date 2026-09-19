from __future__ import annotations

from abc import ABC, abstractmethod
from typing import Any, List, Optional, Tuple

import cv2
import numpy as np

from .types import BoundingBox, Person


class BasePersonDetector(ABC):
    """Common interface for human detection backends."""

    @abstractmethod
    def detect(self, frame: np.ndarray) -> List[Person]:
        """Detect persons in an OpenCV frame.

        Returns structured detections containing bounding box, center_x, center_y,
        and confidence.
        """
        raise NotImplementedError


class HOGPersonDetector(BasePersonDetector):
    """OpenCV HOG-based pedestrian detector (default).

    Uses cv2.HOGDescriptor with the default people detector SVM.
    Does not require deep learning dependencies or GPU acceleration.
    """

    def __init__(
        self,
        confidence: float = 0.0,
        win_stride: Tuple[int, int] = (8, 8),
        padding: Tuple[int, int] = (8, 8),
        scale: float = 1.05,
    ):
        self.confidence = float(confidence)
        self.win_stride = tuple(win_stride)
        self.padding = tuple(padding)
        self.scale = float(scale)
        self.hog = cv2.HOGDescriptor()
        self.hog.setSVMDetector(cv2.HOGDescriptor_getDefaultPeopleDetector())

    def detect(self, frame: np.ndarray) -> List[Person]:
        if frame is None or frame.size == 0:
            return []

        # Optional resizing or grayscale conversion for performance/accuracy
        rects, weights = self.hog.detectMultiScale(
            frame,
            winStride=self.win_stride,
            padding=self.padding,
            scale=self.scale,
        )

        detections: List[Person] = []
        if len(rects) == 0:
            return detections

        flat_weights = np.ravel(weights) if weights is not None and len(weights) > 0 else []

        for i, (x, y, w, h) in enumerate(rects):
            conf = float(flat_weights[i]) if i < len(flat_weights) else 0.5
            if conf >= self.confidence:
                bbox = BoundingBox(int(x), int(y), int(x + w), int(y + h))
                # Initial untracked person detection has track_id = -1
                detections.append(Person(track_id=-1, bbox=bbox, confidence=conf))

        return detections


class YoloPersonDetector(BasePersonDetector):
    """Optional YOLOv8 person detector behind the same detector interface."""

    def __init__(self, model_path: str = "yolov8n.pt", confidence: float = 0.45):
        try:
            from ultralytics import YOLO
        except ImportError as exc:
            raise RuntimeError(
                "Install ultralytics to use the optional YOLO detector backend."
            ) from exc
        self.model = YOLO(str(model_path))
        self.confidence = float(confidence)

    def detect(self, frame: np.ndarray) -> List[Person]:
        if frame is None or frame.size == 0:
            return []
        results = self.model.predict(
            source=frame, classes=[0], conf=self.confidence, verbose=False
        )
        if not results or results[0].boxes is None:
            return []
        people: List[Person] = []
        for box in results[0].boxes:
            x1, y1, x2, y2 = [int(round(v)) for v in box.xyxy[0].tolist()]
            people.append(Person(-1, BoundingBox(x1, y1, x2, y2), float(box.conf[0])))
        return people


class PersonDetector(BasePersonDetector):
    """Unified detector facade defaulting to OpenCV HOG."""

    def __init__(
        self,
        model_or_type: str = "hog",
        confidence: float = 0.0,
        win_stride: Tuple[int, int] = (8, 8),
        padding: Tuple[int, int] = (8, 8),
        scale: float = 1.05,
    ):
        model_str = str(model_or_type).lower().strip()
        if model_str in ("hog", "opencv", "") or not model_str.endswith(".pt"):
            self._backend: BasePersonDetector = HOGPersonDetector(
                confidence=confidence,
                win_stride=win_stride,
                padding=padding,
                scale=scale,
            )
        else:
            self._backend = YoloPersonDetector(
                model_path=model_or_type, confidence=confidence
            )

    def detect(self, frame: np.ndarray) -> List[Person]:
        return self._backend.detect(frame)

    @staticmethod
    def draw(
        frame: np.ndarray,
        people: List[Person],
        target_id: Optional[int] = None,
    ) -> np.ndarray:
        """Visualize detected people and highlight active target with OpenCV."""
        for person in people:
            b = person.bbox
            selected = person.track_id == target_id and target_id is not None
            color = (0, 255, 0) if selected else (255, 100, 0)  # BGR
            thickness = 3 if selected else 2
            cv2.rectangle(frame, (b.x1, b.y1), (b.x2, b.y2), color, thickness)
            label = f"ID {person.track_id}" + (" [TARGET]" if selected else "")
            cv2.putText(
                frame,
                label,
                (b.x1, max(20, b.y1 - 8)),
                cv2.FONT_HERSHEY_SIMPLEX,
                0.6,
                color,
                2,
            )
        return frame


__all__ = [
    "BasePersonDetector",
    "HOGPersonDetector",
    "YoloPersonDetector",
    "PersonDetector",
]
