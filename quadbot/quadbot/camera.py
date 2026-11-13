"""2D Camera feed manager for Intel RealSense D435 and USB cameras."""
import glob
import logging
import os
import threading
import time
from typing import Optional

import numpy as np

log = logging.getLogger("quadbot.camera")

try:
    import cv2
except ImportError:
    cv2 = None

try:
    import pyrealsense2 as rs
except ImportError:
    rs = None


class CameraManager:
    """Manages 2D video capture from Intel RealSense D435 or standard USB cameras.

    Supports on/off toggling, auto-start, graceful reconnection, and MJPEG streaming.
    """

    def __init__(self, width: int = 640, height: int = 480, fps: int = 30):
        self.width = width
        self.height = height
        self.fps = fps
        self.enabled = True
        self.active = False
        self.source = "none"
        self._lock = threading.Lock()
        self._stop_event = threading.Event()
        self._thread: Optional[threading.Thread] = None
        self._latest_jpeg: Optional[bytes] = None
        self._latest_time = 0.0
        self._measured_fps = 0.0

    def start_feed(self):
        with self._lock:
            self.enabled = True
            if self._thread is None or not self._thread.is_alive():
                self._stop_event.clear()
                self._thread = threading.Thread(target=self._capture_loop, daemon=True)
                self._thread.start()

    def stop_feed(self):
        with self._lock:
            self.enabled = False
            self.active = False
            self.source = "none"
            self._stop_event.set()
        if self._thread and self._thread.is_alive():
            self._thread.join(timeout=1.0)
        self._thread = None
        with self._lock:
            self._latest_jpeg = None

    def toggle(self, state: Optional[bool] = None) -> bool:
        new_state = (not self.enabled) if state is None else bool(state)
        if new_state:
            self.start_feed()
        else:
            self.stop_feed()
        return self.enabled

    def get_status(self) -> dict:
        with self._lock:
            return {
                "enabled": self.enabled,
                "active": self.active,
                "source": self.source,
                "resolution": [self.width, self.height],
                "fps": round(self._measured_fps, 1),
            }

    def _render_standby_frame(self, message: str = "Camera Standby") -> bytes:
        if cv2 is None:
            return b""
        frame = np.full((self.height, self.width, 3), 18, dtype=np.uint8)
        cx, cy = self.width // 2, self.height // 2
        # Crosshairs
        cv2.line(frame, (cx - 28, cy), (cx + 28, cy), (55, 65, 81), 1)
        cv2.line(frame, (cx, cy - 28), (cx, cy + 28), (55, 65, 81), 1)
        # Status text
        cv2.putText(
            frame,
            message,
            (24, cy - 8),
            cv2.FONT_HERSHEY_SIMPLEX,
            0.60,
            (56, 189, 248),
            2,
            cv2.LINE_AA,
        )
        t_str = time.strftime("%H:%M:%S")
        subtext = (
            f"Waiting for RealSense / USB camera... [{t_str}]"
            if self.enabled
            else f"Stream Paused to Save Bandwidth [{t_str}]"
        )
        cv2.putText(
            frame,
            subtext,
            (24, cy + 24),
            cv2.FONT_HERSHEY_SIMPLEX,
            0.42,
            (148, 163, 184),
            1,
            cv2.LINE_AA,
        )
        _, jpeg = cv2.imencode(".jpg", frame, [cv2.IMWRITE_JPEG_QUALITY, 80])
        return jpeg.tobytes()

    def _get_ranked_v4l2_devices(self) -> list:
        v4l_devices = []
        for path in sorted(glob.glob("/sys/class/video4linux/video*")):
            try:
                idx = int(os.path.basename(path).replace("video", ""))
                name_file = os.path.join(path, "name")
                dev_name = ""
                if os.path.exists(name_file):
                    with open(name_file) as f:
                        dev_name = f.read().strip()
                v4l_devices.append((idx, dev_name))
            except Exception:
                pass

        def rank_device(item):
            idx, name = item
            nl = name.lower()
            if "realsense" in nl or "d435" in nl:
                return 0
            if "rgb" in nl or "color" in nl or nl.endswith(" f"):
                return 1
            if "fhd" in nl or "webcam" in nl:
                return 2
            if "ir" in nl or nl.endswith(" i") or "metadata" in nl:
                return 99
            return 10

        v4l_devices.sort(key=rank_device)
        return v4l_devices

    def _capture_loop(self):
        log.info("Starting camera capture loop")
        pipeline = None
        cap = None

        while not self._stop_event.is_set() and self.enabled:
            # 1. Try Intel RealSense native pipeline via pyrealsense2
            if rs is not None:
                try:
                    ctx = rs.context()
                    devices = list(ctx.query_devices())
                    if devices:
                        dev_name = devices[0].get_info(rs.camera_info.name)
                        log.info(f"Connecting to RealSense device: {dev_name}")
                        pipeline = rs.pipeline()
                        config = rs.config()
                        try:
                            config.enable_stream(
                                rs.stream.color,
                                self.width,
                                self.height,
                                rs.format.bgr8,
                                self.fps,
                            )
                            pipeline.start(config)
                        except Exception:
                            config = rs.config()
                            config.enable_stream(rs.stream.color)
                            pipeline.start(config)

                        with self._lock:
                            self.active = True
                            self.source = f"realsense:{dev_name}"

                        fps_t0 = time.monotonic()
                        frame_cnt = 0
                        while not self._stop_event.is_set() and self.enabled:
                            frames = pipeline.wait_for_frames(timeout_ms=1000)
                            color_frame = frames.get_color_frame()
                            if not color_frame:
                                continue
                            img = np.asanyarray(color_frame.get_data())
                            if cv2 is not None:
                                _, jpeg = cv2.imencode(
                                    ".jpg", img, [cv2.IMWRITE_JPEG_QUALITY, 80]
                                )
                                with self._lock:
                                    self._latest_jpeg = jpeg.tobytes()
                                    self._latest_time = time.monotonic()

                            frame_cnt += 1
                            if time.monotonic() - fps_t0 >= 1.0:
                                self._measured_fps = frame_cnt / (time.monotonic() - fps_t0)
                                fps_t0 = time.monotonic()
                                frame_cnt = 0

                        pipeline.stop()
                        pipeline = None
                except Exception as ex:
                    log.warning(f"RealSense pipeline attempt: {ex}")
                    if pipeline is not None:
                        try:
                            pipeline.stop()
                        except Exception:
                            pass
                        pipeline = None

            if self._stop_event.is_set() or not self.enabled:
                break

            # 2. Try V4L2 USB camera (OpenCV VideoCapture with ranked devices)
            if cv2 is not None and not self.active:
                ranked_devs = self._get_ranked_v4l2_devices()
                candidates = [idx for idx, _ in ranked_devs] or [0, 1, 2]

                for dev_idx in candidates:
                    try:
                        api_pref = cv2.CAP_V4L2 if hasattr(cv2, "CAP_V4L2") else cv2.CAP_ANY
                        cap = cv2.VideoCapture(dev_idx, api_pref)
                        if cap.isOpened():
                            cap.set(cv2.CAP_PROP_FRAME_WIDTH, self.width)
                            cap.set(cv2.CAP_PROP_FRAME_HEIGHT, self.height)
                            cap.set(cv2.CAP_PROP_FPS, self.fps)
                            ret, frame = cap.read()
                            if ret and frame is not None:
                                dev_label = f"/dev/video{dev_idx}"
                                # Check sysfs name if matches RealSense
                                for idx_r, name_r in ranked_devs:
                                    if idx_r == dev_idx and (
                                        "realsense" in name_r.lower()
                                        or "d435" in name_r.lower()
                                    ):
                                        dev_label = f"RealSense ({name_r})"
                                        break
                                with self._lock:
                                    self.active = True
                                    self.source = f"v4l2:{dev_label}"
                                log.info(f"Connected to V4L2 camera on {dev_label}")

                                fps_t0 = time.monotonic()
                                frame_cnt = 0
                                check_rs_t0 = time.monotonic()

                                while not self._stop_event.is_set() and self.enabled:
                                    ret, frame = cap.read()
                                    if not ret or frame is None:
                                        break
                                    _, jpeg = cv2.imencode(
                                        ".jpg", frame, [cv2.IMWRITE_JPEG_QUALITY, 80]
                                    )
                                    with self._lock:
                                        self._latest_jpeg = jpeg.tobytes()
                                        self._latest_time = time.monotonic()

                                    frame_cnt += 1
                                    now = time.monotonic()
                                    if now - fps_t0 >= 1.0:
                                        self._measured_fps = frame_cnt / (now - fps_t0)
                                        fps_t0 = now
                                        frame_cnt = 0

                                    # Every 5 seconds, check if native RealSense was just plugged in
                                    if rs is not None and (now - check_rs_t0 >= 5.0):
                                        check_rs_t0 = now
                                        try:
                                            if len(list(rs.context().query_devices())) > 0:
                                                log.info(
                                                    "New RealSense device detected; switching..."
                                                )
                                                break
                                        except Exception:
                                            pass

                                cap.release()
                                cap = None
                                break
                            cap.release()
                            cap = None
                    except Exception as e:
                        log.debug(f"V4L2 index {dev_idx} open attempt failed: {e}")
                        if cap is not None:
                            cap.release()
                            cap = None

            if self._stop_event.is_set() or not self.enabled:
                break

            # 3. Output standby frame while waiting for connection
            with self._lock:
                self.active = False
                self.source = "standby"
                self._latest_jpeg = self._render_standby_frame(
                    "Searching for RealSense / USB camera..."
                )
                self._latest_time = time.monotonic()
            time.sleep(1.0)

        with self._lock:
            self.active = False
            self.source = "none"
            self._latest_jpeg = None
        log.info("Camera capture loop stopped")

    def get_latest_jpeg(self) -> bytes:
        with self._lock:
            if self._latest_jpeg is not None:
                return self._latest_jpeg
            msg = (
                "Camera Initializing..."
                if self.enabled
                else "Camera Feed Paused (Toggle On)"
            )
            return self._render_standby_frame(msg)
