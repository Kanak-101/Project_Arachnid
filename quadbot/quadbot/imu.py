"""MPU-6050 attitude reader with axis remapping, complementary filter, and calibration."""
import math
import threading
import time
from typing import Dict, Optional, Tuple


class MPU6050:
    PWR_MGMT_1 = 0x6B
    ACCEL_XOUT_H = 0x3B
    GYRO_XOUT_H = 0x43

    def __init__(
        self,
        bus_num: int = 1,
        address: int = 0x68,
        rate_hz: int = 100,
        alpha: float = 0.98,
        axis_map: Optional[Dict] = None,
        offsets: Optional[Dict] = None,
    ):
        self.bus_num = bus_num
        self.address = address
        self.rate_hz = rate_hz
        self.alpha = alpha

        # Axis mapping: maps robot frame (forward, left, up) to sensor axes ("x", "y", "z") with signs (+1 or -1)
        self.axis_map = self._clean_axis_map(axis_map)
        self.offsets = {
            "roll_deg": float(offsets.get("roll_deg", 0.0)) if offsets else 0.0,
            "pitch_deg": float(offsets.get("pitch_deg", 0.0)) if offsets else 0.0,
        }

        self.raw_accel = (0.0, 0.0, 1.0)
        self.raw_gyro = (0.0, 0.0, 0.0)
        self.roll = 0.0
        self.pitch = 0.0
        self.roll_comp = 0.0
        self.pitch_comp = 0.0

        self.ready = False
        self.error = ""
        self._stop = threading.Event()
        self._thread = None
        self._lock = threading.Lock()
        self._bus = None

    @staticmethod
    def _clean_axis_map(raw_map: Optional[Dict]) -> Dict[str, Tuple[str, int]]:
        default_map = {"forward": ("x", 1), "left": ("y", 1), "up": ("z", 1)}
        if not raw_map:
            return default_map
        cleaned = {}
        for key in ("forward", "left", "up"):
            entry = raw_map.get(key, default_map[key])
            if isinstance(entry, (list, tuple)) and len(entry) == 2:
                ax = str(entry[0]).lower().replace("-", "").replace("+", "")
                sign = -1 if "-" in str(entry[0]) or int(entry[1]) < 0 else 1
                cleaned[key] = (ax, sign)
            else:
                cleaned[key] = default_map[key]
        return cleaned

    def update_config(self, axis_map: Optional[Dict] = None, offsets: Optional[Dict] = None):
        with self._lock:
            if axis_map is not None:
                self.axis_map = self._clean_axis_map(axis_map)
            if offsets is not None:
                self.offsets = {
                    "roll_deg": float(offsets.get("roll_deg", 0.0)),
                    "pitch_deg": float(offsets.get("pitch_deg", 0.0)),
                }
            self.roll = 0.0
            self.pitch = 0.0

    @staticmethod
    def _signed(high, low):
        value = (high << 8) | low
        return value - 65536 if value & 0x8000 else value

    def start(self):
        try:
            from smbus2 import SMBus
            self._bus = SMBus(self.bus_num)
            self._bus.write_byte_data(self.address, self.PWR_MGMT_1, 0)
            self.ready = True
            self._thread = threading.Thread(target=self._run, daemon=True)
            self._thread.start()
        except Exception as exc:
            self.error = str(exc)
            self.ready = False

    def _read_hardware(self):
        if not self._bus:
            return (0.0, 0.0, 1.0), (0.0, 0.0, 0.0)
        data = self._bus.read_i2c_block_data(self.address, self.ACCEL_XOUT_H, 14)
        ax = self._signed(data[0], data[1]) / 16384.0
        ay = self._signed(data[2], data[3]) / 16384.0
        az = self._signed(data[4], data[5]) / 16384.0
        gx = self._signed(data[8], data[9]) / 131.0
        gy = self._signed(data[10], data[11]) / 131.0
        gz = self._signed(data[12], data[13]) / 131.0
        return (ax, ay, az), (gx, gy, gz)

    def _map_to_robot(self, ax: float, ay: float, az: float, gx: float, gy: float, gz: float):
        raw_a = {"x": ax, "y": ay, "z": az}
        raw_g = {"x": gx, "y": gy, "z": gz}
        f_ax, f_sign = self.axis_map["forward"]
        l_ax, l_sign = self.axis_map["left"]
        u_ax, u_sign = self.axis_map["up"]

        r_ax = raw_a.get(f_ax, 0.0) * f_sign
        r_ay = raw_a.get(l_ax, 0.0) * l_sign
        r_az = raw_a.get(u_ax, 0.0) * u_sign

        r_gx = raw_g.get(f_ax, 0.0) * f_sign
        r_gy = raw_g.get(l_ax, 0.0) * l_sign
        r_gz = raw_g.get(u_ax, 0.0) * u_sign

        return (r_ax, r_ay, r_az), (r_gx, r_gy, r_gz)

    def _run(self):
        last = time.monotonic()
        while not self._stop.wait(1.0 / self.rate_hz):
            try:
                (ax, ay, az), (gx, gy, gz) = self._read_hardware()
                with self._lock:
                    self.raw_accel = (ax, ay, az)
                    self.raw_gyro = (gx, gy, gz)

                (r_ax, r_ay, r_az), (r_gx, r_gy, r_gz) = self._map_to_robot(ax, ay, az, gx, gy, gz)

                # Accelerometer roll and pitch in robot frame (deg)
                roll_acc = math.degrees(math.atan2(r_ay, r_az))
                pitch_acc = math.degrees(math.atan2(-r_ax, math.hypot(r_ay, r_az)))

                now = time.monotonic()
                dt = min(max(now - last, 0.001), 0.1)
                last = now

                with self._lock:
                    self.roll = self.alpha * (self.roll + r_gx * dt) + (1.0 - self.alpha) * roll_acc
                    self.pitch = self.alpha * (self.pitch + r_gy * dt) + (1.0 - self.alpha) * pitch_acc
                    self.roll_comp = self.roll - self.offsets.get("roll_deg", 0.0)
                    self.pitch_comp = self.pitch - self.offsets.get("pitch_deg", 0.0)
            except Exception as exc:
                self.error = str(exc)
                self.ready = False

    def attitude(self) -> Tuple[float, float]:
        with self._lock:
            return self.roll_comp, self.pitch_comp

    def get_state(self) -> dict:
        with self._lock:
            return {
                "ready": self.ready,
                "error": self.error,
                "roll": round(self.roll_comp, 2),
                "pitch": round(self.pitch_comp, 2),
                "raw_roll": round(self.roll, 2),
                "raw_pitch": round(self.pitch, 2),
                "raw_accel": [round(v, 3) for v in self.raw_accel],
                "raw_gyro": [round(v, 2) for v in self.raw_gyro],
                "axis_map": self.axis_map,
                "offsets": self.offsets,
            }

    def sample_average(self, duration_s: float = 0.6, count: int = 30) -> Tuple[Tuple[float, float, float], Tuple[float, float, float]]:
        """Collects average raw accelerometer and gyro values over a short duration."""
        acc_samples = []
        gyro_samples = []
        interval = duration_s / max(count, 1)

        for _ in range(count):
            if self._bus and self.ready:
                try:
                    a, g = self._read_hardware()
                    acc_samples.append(a)
                    gyro_samples.append(g)
                except Exception:
                    with self._lock:
                        acc_samples.append(self.raw_accel)
                        gyro_samples.append(self.raw_gyro)
            else:
                with self._lock:
                    acc_samples.append(self.raw_accel)
                    gyro_samples.append(self.raw_gyro)
            time.sleep(interval)

        if not acc_samples:
            return (0.0, 0.0, 1.0), (0.0, 0.0, 0.0)

        mean_a = (
            sum(s[0] for s in acc_samples) / len(acc_samples),
            sum(s[1] for s in acc_samples) / len(acc_samples),
            sum(s[2] for s in acc_samples) / len(acc_samples),
        )
        mean_g = (
            sum(s[0] for s in gyro_samples) / len(gyro_samples),
            sum(s[1] for s in gyro_samples) / len(gyro_samples),
            sum(s[2] for s in gyro_samples) / len(gyro_samples),
        )
        return mean_a, mean_g

    def close(self):
        self._stop.set()
        if self._thread:
            self._thread.join(timeout=0.2)
        if self._bus:
            try:
                self._bus.close()
            except Exception:
                pass