"""
sensor_node.py  –  Project Arachnid
Runs ALL sensors concurrently in daemon threads.
Exposes a single get_all() dict for the server to stream.

Sensors (from mind-map):
  1. MQ-2,4,5,6,7,8  Gas sensors        → Arduino Uno via Serial (analog mux)
  2. DHT11            Temp/Humidity      → RPi GPIO (pin 4)
  3. HC-SR04 ×N      Ultrasonic         → Arduino Uno via Serial
  4. MPU6050          Gyroscope/IMU      → RPi I2C (0x68)
  5. GPS M8N          NMEA over UART     → /dev/ttyAMA0  (or USB)
  6. RPi Camera       OpenCV stream      → /dev/video0

Install deps:
  pip3 install adafruit-circuitpython-dht adafruit-circuitpython-mpu6050
  pip3 install pyserial pynmea2 opencv-python
  sudo apt install libgpiod2
"""

import threading
import time
import json
import math

# ── Shared state ──────────────────────────────────────────────────────────────
_lock = threading.Lock()
_data = {
    "gas":        {"MQ2": 0, "MQ4": 0, "MQ5": 0, "MQ6": 0, "MQ7": 0, "MQ8": 0},
    "dht":        {"temp_c": 0.0, "humidity_pct": 0.0},
    "ultrasonic": {"front_cm": 999, "left_cm": 999, "right_cm": 999},
    "imu":        {"accel_x": 0, "accel_y": 0, "accel_z": 0,
                   "gyro_x": 0, "gyro_y": 0, "gyro_z": 0,
                   "roll_deg": 0, "pitch_deg": 0},
    "gps":        {"lat": 0.0, "lon": 0.0, "fix": False, "sats": 0},
    "alerts":     [],
    "timestamp":  0.0,
}

# ── Alert thresholds ──────────────────────────────────────────────────────────
GAS_THRESHOLD      = 400    # ADC units (0-1023)
TEMP_MAX_C         = 55.0
OBSTACLE_CM        = 25.0   # warn if ultrasonic < this


def _update(section: str, values: dict):
    with _lock:
        _data[section].update(values)
        _data["timestamp"] = time.time()


def _check_alerts():
    alerts = []
    with _lock:
        for sensor, val in _data["gas"].items():
            if val > GAS_THRESHOLD:
                alerts.append(f"HIGH_GAS:{sensor}={val}")
        if _data["dht"]["temp_c"] > TEMP_MAX_C:
            alerts.append(f"HIGH_TEMP:{_data['dht']['temp_c']:.1f}C")
        for loc, val in _data["ultrasonic"].items():
            if val < OBSTACLE_CM:
                alerts.append(f"OBSTACLE:{loc}={val}cm")
        _data["alerts"] = alerts


def get_all() -> dict:
    with _lock:
        return dict(_data)


# ── Thread: Arduino serial (gas + ultrasonic) ─────────────────────────────────
def _arduino_thread(port="/dev/ttyUSB0", baud=115200):
    """
    Arduino sends a JSON line every 100 ms:
    {"MQ2":320,"MQ4":0,"MQ5":0,"MQ6":0,"MQ7":0,"MQ8":0,
     "front":180,"left":999,"right":999}
    """
    try:
        import serial
        ser = serial.Serial(port, baud, timeout=1)
        print(f"[sensor] Arduino connected on {port}")
        while True:
            try:
                line = ser.readline().decode("utf-8", errors="ignore").strip()
                if not line:
                    continue
                payload = json.loads(line)
                _update("gas", {
                    "MQ2": payload.get("MQ2", 0),
                    "MQ4": payload.get("MQ4", 0),
                    "MQ5": payload.get("MQ5", 0),
                    "MQ6": payload.get("MQ6", 0),
                    "MQ7": payload.get("MQ7", 0),
                    "MQ8": payload.get("MQ8", 0),
                })
                _update("ultrasonic", {
                    "front_cm": payload.get("front", 999),
                    "left_cm":  payload.get("left",  999),
                    "right_cm": payload.get("right", 999),
                })
                _check_alerts()
            except json.JSONDecodeError:
                pass
            except Exception as e:
                print(f"[sensor/arduino] read error: {e}")
    except Exception as e:
        print(f"[sensor/arduino] INIT FAILED: {e} — using dummy data")
        while True:
            time.sleep(1)


# ── Thread: DHT11 temperature/humidity ───────────────────────────────────────
def _dht_thread(gpio_pin=4, interval=2.0):
    try:
        import board
        import adafruit_dht
        pin_map = {4: board.D4, 17: board.D17, 27: board.D27}
        dht = adafruit_dht.DHT11(pin_map.get(gpio_pin, board.D4))
        print("[sensor] DHT11 initialised.")
        while True:
            try:
                temp = dht.temperature
                hum  = dht.humidity
                if temp is not None and hum is not None:
                    _update("dht", {"temp_c": round(temp, 1),
                                    "humidity_pct": round(hum, 1)})
                    _check_alerts()
            except RuntimeError:
                pass   # DHT11 read errors are common; ignore and retry
            except Exception as e:
                print(f"[sensor/dht] error: {e}")
            time.sleep(interval)
    except Exception as e:
        print(f"[sensor/dht] INIT FAILED: {e} — using dummy data")
        while True:
            time.sleep(2)


# ── Thread: MPU6050 IMU ───────────────────────────────────────────────────────
def _imu_thread(interval=0.05):
    try:
        import board
        import busio
        import adafruit_mpu6050
        i2c = busio.I2C(board.SCL, board.SDA)
        mpu = adafruit_mpu6050.MPU6050(i2c)
        print("[sensor] MPU6050 IMU initialised.")
        while True:
            try:
                ax, ay, az = mpu.acceleration
                gx, gy, gz = mpu.gyro
                # Simple roll/pitch from accelerometer
                roll  = math.degrees(math.atan2(ay, az))
                pitch = math.degrees(math.atan2(-ax, math.sqrt(ay**2 + az**2)))
                _update("imu", {
                    "accel_x": round(ax, 3),
                    "accel_y": round(ay, 3),
                    "accel_z": round(az, 3),
                    "gyro_x":  round(gx, 3),
                    "gyro_y":  round(gy, 3),
                    "gyro_z":  round(gz, 3),
                    "roll_deg":  round(roll, 1),
                    "pitch_deg": round(pitch, 1),
                })
            except Exception as e:
                print(f"[sensor/imu] error: {e}")
            time.sleep(interval)
    except Exception as e:
        print(f"[sensor/imu] INIT FAILED: {e} — using dummy data")
        while True:
            time.sleep(0.05)


# ── Thread: GPS M8N ───────────────────────────────────────────────────────────
def _gps_thread(port="/dev/ttyAMA0", baud=9600):
    try:
        import serial
        import pynmea2
        ser = serial.Serial(port, baud, timeout=1)
        print(f"[sensor] GPS connected on {port}")
        while True:
            try:
                line = ser.readline().decode("ascii", errors="ignore").strip()
                if line.startswith("$GNGGA") or line.startswith("$GPGGA"):
                    msg = pynmea2.parse(line)
                    fix = int(msg.gps_qual) > 0 if msg.gps_qual else False
                    _update("gps", {
                        "lat":  float(msg.latitude)  if msg.latitude  else 0.0,
                        "lon":  float(msg.longitude) if msg.longitude else 0.0,
                        "fix":  fix,
                        "sats": int(msg.num_sats)    if msg.num_sats  else 0,
                    })
            except Exception:
                pass
    except Exception as e:
        print(f"[sensor/gps] INIT FAILED: {e} — using dummy data")
        while True:
            time.sleep(1)


# ── Start all sensor threads ──────────────────────────────────────────────────
def start_all(
    arduino_port = "/dev/ttyUSB0",
    gps_port     = "/dev/ttyAMA0",
    dht_pin      = 4,
):
    """Launch all sensor threads as daemons. Call once at startup."""
    threads = [
        threading.Thread(target=_arduino_thread, args=(arduino_port,), daemon=True, name="arduino"),
        threading.Thread(target=_dht_thread,     args=(dht_pin,),      daemon=True, name="dht"),
        threading.Thread(target=_imu_thread,                           daemon=True, name="imu"),
        threading.Thread(target=_gps_thread,     args=(gps_port,),     daemon=True, name="gps"),
    ]
    for t in threads:
        t.start()
        print(f"[sensor] Started thread: {t.name}")
    return threads
