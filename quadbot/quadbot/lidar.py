"""Lidar drivers. Both publish a 360-bin scan: distance in mm at each degree, in the
robot frame (0 deg = forward, angles increase counter-clockwise / to the left).
A distance of 0 means "no valid return".
"""
import math
import threading
import time

import numpy as np


class LidarBase:
    def __init__(self, mask_deg=None):
        self._lock = threading.Lock()
        self._scan = np.zeros(360, dtype=np.float32)
        self._t = 0.0
        self.status = "starting"
        self._stop = threading.Event()
        self._thread = None
        self.mask = np.zeros(360, dtype=bool)
        for a, b in (mask_deg or []):
            span = (int(b) - int(a)) % 360
            for i in range(span + 1):
                self.mask[(int(a) + i) % 360] = True

    def start(self):
        self._thread = threading.Thread(target=self._run, daemon=True)
        self._thread.start()

    def stop(self):
        self._stop.set()

    def _publish(self, scan):
        scan = scan.astype(np.float32)
        scan[self.mask] = 0.0
        with self._lock:
            self._scan, self._t = scan, time.monotonic()

    def snapshot(self):
        """Latest scan (copy) and its age in seconds."""
        with self._lock:
            age = time.monotonic() - self._t if self._t else float("inf")
            return self._scan.copy(), age

    def _run(self):
        raise NotImplementedError


class MockLidar(LidarBase):
    """A 4 m x 3 m room with someone walking around, plus an obstacle you can toggle."""

    def __init__(self, **kw):
        super().__init__(**kw)
        self.obstacle = None   # distance in mm straight ahead, or None

    def set_obstacle(self, dist_mm):
        self.obstacle = dist_mm

    def _ray_scan(self, t):
        th = np.radians(np.arange(360))
        dx, dy = np.cos(th), np.sin(th)
        xmin, xmax, ymin, ymax = -1.5, 2.5, -1.5, 1.5
        with np.errstate(divide="ignore", invalid="ignore"):
            tx = np.where(dx > 1e-9, xmax / dx, np.where(dx < -1e-9, xmin / dx, np.inf))
            ty = np.where(dy > 1e-9, ymax / dy, np.where(dy < -1e-9, ymin / dy, np.inf))
        dist = np.minimum(tx, ty)
        circles = [(1.2 * math.cos(t * 0.4) + 0.5, 1.0 * math.sin(t * 0.4), 0.25)]
        if self.obstacle is not None:
            circles.append((self.obstacle / 1000.0 + 0.15, 0.0, 0.15))
        for cx, cy, r in circles:
            b = dx * cx + dy * cy
            disc = b * b - (cx * cx + cy * cy - r * r)
            hit = (b > 0) & (disc >= 0)
            tt = np.where(hit, b - np.sqrt(np.maximum(disc, 0)), np.inf)
            dist = np.minimum(dist, tt)
        return dist * 1000.0 + np.random.normal(0, 4, 360)

    def _run(self):
        self.status = "mock"
        t0 = time.monotonic()
        while not self._stop.is_set():
            self._publish(self._ray_scan(time.monotonic() - t0))
            time.sleep(0.125)


class RPLidarDriver(LidarBase):
    """Slamtec RPLidar via the `rplidar-roboticia` package (pip install rplidar-roboticia)."""

    def __init__(self, port, baud=115200, clockwise=True, offset_deg=0, **kw):
        super().__init__(**kw)
        self.port, self.baud, self.cw, self.offset = port, baud, clockwise, offset_deg

    def _run(self):
        from rplidar import RPLidar, RPLidarException

        while not self._stop.is_set():
            lidar = None
            try:
                self.status = "connecting"
                lidar = RPLidar(self.port, baudrate=self.baud, timeout=3)
                lidar.clean_input()
                self.status = "running"
                for scan in lidar.iter_scans(max_buf_meas=5000):
                    if self._stop.is_set():
                        break
                    bins = np.zeros(360, dtype=np.float32)
                    for _quality, angle, dist in scan:
                        a = (-angle if self.cw else angle) + self.offset
                        i = int(round(a)) % 360
                        if dist > 0 and (bins[i] == 0 or dist < bins[i]):
                            bins[i] = dist
                    self._publish(bins)
            except (RPLidarException, OSError, ValueError) as e:  # reconnect after any serial hiccup
                self.status = f"error: {e}"[:80]
                time.sleep(1.0)
            finally:
                if lidar is not None:
                    try:
                        lidar.stop()
                        lidar.stop_motor()
                        lidar.disconnect()
                    except Exception:
                        pass


def make_lidar(cfg):
    c = cfg.get("lidar", {})
    mask = c.get("mask_deg", [])
    if c.get("driver", "mock") == "rplidar":
        return RPLidarDriver(c["port"], c.get("baud", 115200), c.get("clockwise", True),
                             c.get("mount_offset_deg", 0), mask_deg=mask)
    return MockLidar(mask_deg=mask)
