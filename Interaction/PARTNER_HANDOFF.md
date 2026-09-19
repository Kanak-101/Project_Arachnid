# Project Arachnid — Human Interaction Feature Partner Handoff

This document details the interface contract between the laptop-side Human Interaction module and the Project Arachnid robot controller.

---

## 1. System Boundary

```text
[Laptop Side: Human Interaction Feature]
  - Camera acquisition (OpenCV)
  - Pedestrian detection (cv2.HOGDescriptor)
  - RPLiDAR spatial candidate extraction & fusion
  - Single target selection & locking
  - Approach navigation decisions
  - Human wave gesture detection
  - High-level MotionCommand generation
        │
        ▼ (JSON-lines over USB Serial or TCP)
[Robot Controller Side: Project Arachnid Controller]
  - Command parsing
  - Gait generation (tripod locomotion, wave choreography, shake kinematics)
  - Inverse kinematics & servo PWM control (PCA9685, ESP32, etc.)
```

The laptop-side code does **not** implement servo angles, PWM pulses, or low-level gait cycles. It outputs high-level motion requests.

---

## 2. Command Protocol

Commands are emitted as single JSON objects terminated by a newline (`\n`):

```json
{"command": "<COMMAND_NAME>", "duration_s": <FLOAT_SECONDS>}
```

Optional parameters may be included in `"parameters"`:

```json
{"command": "<COMMAND_NAME>", "duration_s": <FLOAT_SECONDS>, "parameters": {...}}
```

### Supported Commands

| Command | Standard Duration | Description |
| :--- | :--- | :--- |
| `FORWARD` | 5.0 s | Move forward towards target |
| `BACKWARD` | 5.0 s | Back away if target is inside minimum distance |
| `TURN_LEFT` | 5.0 s | Rotate left to center target on optical axis |
| `TURN_RIGHT` | 5.0 s | Rotate right to center target on optical axis |
| `STOP` | 0.0 s | Halt immediately (reached distance, lost target, or emergency) |
| `SHAKE` | 6.0 s | Whole-body arrival shake on reaching interaction zone |
| `LEG_WAVE` | 6.0 s | Single front leg wave responding to target's wave |
| `DANCE` | 8.0 s | Six-leg demonstration dance routine |

---

## 3. Hardware Team Calibration Points

Values that should be tuned for the physical robot are configured in `config/default.yaml`:

- **Camera Horizontal FOV**: `camera.horizontal_fov_deg` (default `62.0` deg). Match the actual lens focal length.
- **LiDAR Mount Angle & Offset**: Ensure 0 deg on RPLiDAR matches the camera forward axis.
- **Interaction Range**: `approach.minimum_distance_m` (default `1.30m`) and `approach.maximum_distance_m` (default `1.70m`).
- **Emergency Stop Distance**: `approach.emergency_stop_m` (default `0.45m`).
- **Movement Durations**: Configurable between 5.0 and 10.0 seconds in `motions.*`.

---

## 4. Verification Checklist Before Hardware Link

1. Run automated tests:
   ```bash
   python -m pytest
   ```
2. Verify motions script:
   ```bash
   python scripts/test_motions.py
   ```
3. Test manual control in console mode:
   ```bash
   python scripts/manual_control.py --transport console
   ```
4. Test camera detection:
   ```bash
   python scripts/test_camera.py --camera 0
   ```
5. When ready to connect to robot controller over serial:
   ```bash
   python scripts/manual_control.py --transport serial --serial-port COM4 --serial-baudrate 115200
   ```
