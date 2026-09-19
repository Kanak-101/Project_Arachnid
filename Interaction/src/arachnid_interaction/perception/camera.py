from __future__ import annotations

from typing import Any, Tuple, Union

import cv2
import numpy as np


class Camera:
    """OpenCV VideoCapture camera source with configurable resolution and frame rate."""

    def __init__(
        self,
        source: Union[int, str] = 0,
        index: Union[int, str, None] = None,
        width: int = 1280,
        height: int = 720,
        fps: int = 30,
    ):
        actual_source = index if index is not None else source
        if isinstance(actual_source, str) and actual_source.isdigit():
            actual_source = int(actual_source)
        self.source = actual_source
        self.width = width
        self.height = height
        self.fps = fps

        self.capture = cv2.VideoCapture(self.source)
        if not self.capture.isOpened():
            raise RuntimeError(f"Unable to open camera source {self.source!r}")

        self.capture.set(cv2.CAP_PROP_FRAME_WIDTH, float(width))
        self.capture.set(cv2.CAP_PROP_FRAME_HEIGHT, float(height))
        self.capture.set(cv2.CAP_PROP_FPS, float(fps))

    def is_opened(self) -> bool:
        return self.capture is not None and self.capture.isOpened()

    def read(self) -> np.ndarray:
        if not self.is_opened():
            raise RuntimeError("Camera is not opened")
        ok, frame = self.capture.read()
        if not ok or frame is None:
            raise RuntimeError("Camera frame read failed")
        return frame

    def release(self) -> None:
        if self.capture is not None:
            self.capture.release()


def resize_frame(frame: np.ndarray, width: int, height: int) -> np.ndarray:
    """Resize an OpenCV frame to specified dimensions."""
    return cv2.resize(frame, (width, height), interpolation=cv2.INTER_LINEAR)


def to_grayscale(frame: np.ndarray) -> np.ndarray:
    """Convert a BGR frame to grayscale."""
    if len(frame.shape) == 2:
        return frame
    return cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)


__all__ = ["Camera", "resize_frame", "to_grayscale"]

