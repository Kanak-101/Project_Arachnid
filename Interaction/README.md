# Project Arachnid — Human Interaction Feature

## Purpose

This module provides local perception and interaction behavior for Project Arachnid (`https://github.com/Kanak-101/Project_Arachnid`).

It runs on a local development laptop and computes high-level target selection, navigation decisions, and gesture-triggered behaviors from camera and LiDAR inputs.

> **Explicit Limitation:**
> This module does not implement the robot's low-level servo control or gait generation. It produces high-level movement commands for integration with the existing Project Arachnid controller. Physical hardware motion depends entirely on the controller layer translating these commands into gait cycles and PWM signals.

---

## Features

- **LiDAR-based spatial candidate discovery**: Processes 360-degree point clouds from RPLiDAR to detect distance and angular clusters.
- **OpenCV human detection**: Uses `cv2.HOGDescriptor` and the default OpenCV people detector SVM to locate pedestrians in camera frames without requiring deep learning frameworks.
- **Single-target tracking**: Maintains temporary track IDs across frames and associates detected persons with LiDAR candidate bearings.
- **Deterministic target selection**: Evaluates candidates using LiDAR verification, proximity, alignment, and bounding box scale to pick exactly one person.
- **Target locking**: Focuses on the selected individual; ignores other detected persons while the lock is active.
- **Target-loss recovery**: Automatically releases target lock after a configurable timeout if the person leaves the field of view, returning to the searching state.
- **Left/right alignment**: Computes angular offset from the optical axis to command left or right turns.
- **Forward/backward movement decisions**: Regulates distance to reach a configured interaction zone (1.3m – 1.7m).
- **Movement durations (5–10 seconds)**: Continuous navigation commands specify explicit durations (5.0s default) suitable for demonstration gaits.
- **Emergency stop**: Halts immediately if an obstacle or person enters the safety threshold (< 0.45m).
- **Whole-body shake command**: Emits an arrival shake (`SHAKE`, 6.0s) when reaching the interaction threshold.
- **Human wave detection**: Tracks hand movement within the locked person's bounding box over consecutive frames, requiring alternating horizontal reversals to distinguish intentional waving from static posture.
- **One-leg wave command**: Emits a response wave (`LEG_WAVE`, 6.0s) only when the locked target waves.
- **Six-leg dance command**: Emits a demonstration dance routine (`DANCE`, 8.0s).
- **Laptop manual control**: Keyboard-driven manual utility (`scripts/manual_control.py`) over console, serial, or TCP.
- **Comprehensive test harness**: 43 automated tests validating perception, tracking, approach logic, gestures, controller protocol translation, and safety rules without requiring physical hardware.

---

## Architecture

```text
LiDAR
  ↓
Candidate
  ↓
Camera
  ↓
OpenCV Human Detection
  ↓
Target Tracker
  ↓
Behavior State Machine
  ↓
High-Level Motion Command
  ↓
Existing Project Arachnid Controller
```

---

## High-Level Motion Commands

Commands emitted by this module are high-level JSON lines:

```json
{"command": "FORWARD", "duration_s": 5.0}
{"command": "BACKWARD", "duration_s": 5.0}
{"command": "TURN_LEFT", "duration_s": 5.0}
{"command": "TURN_RIGHT", "duration_s": 5.0}
{"command": "STOP", "duration_s": 0.0}
{"command": "LEG_WAVE", "duration_s": 6.0}
{"command": "SHAKE", "duration_s": 6.0}
{"command": "DANCE", "duration_s": 8.0}
```

The robot controller consumes these commands over USB serial, TCP, or console output.

---

## State Machine

The interaction system operates across three explicit states:

```text
SEARCHING
  │
  ├─ RPLiDAR finds spatial candidates
  ├─ Camera checks candidate bearing
  ├─ OpenCV confirms human
  └─ Lock target ID ─────────────────────────┐
                                             ↓
                                        APPROACHING
                                             │
  ┌─ Target lost (> timeout) ────────────────┤
  │                                          ├─ Target left      → TURN_LEFT (5s)
  │                                          ├─ Target right     → TURN_RIGHT (5s)
  │                                          ├─ Target far       → FORWARD (5s)
  │                                          ├─ Target too close → BACKWARD (5s)
  │                                          └─ Target reached   → STOP (0s) + SHAKE (6s)
  │                                                                    │
  │                                                                    ↓
  │                                                               INTERACTING
  │                                                                    │
  ├─ Target lost (> timeout) ──────────────────────────────────────────┤
  │                                                                    ├─ Selected human waves → LEG_WAVE (6s)
  │                                                                    └─ Manual triggers → DANCE (8s), etc.
  ↓
SEARCHING (idle / sweep)
```

---

## Installation & Setup

1. Create and activate a Python virtual environment (Python 3.10+):
   ```bash
   python -m venv .venv
   .\.venv\Scripts\activate   # Windows
   # or: source .venv/bin/activate  # Linux/macOS
   ```

2. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

3. Run the automated test suite:
   ```bash
   python -m pytest
   ```

---

## Test Scripts

### 1. Motion Command Validation
Validates duration configurations (5–10s) and serialization:
```bash
python scripts/test_motions.py
```

### 2. Manual Laptop Control
Sends motion commands to console (or physical serial port):
```bash
python scripts/manual_control.py --transport console
```
Key mapping:
- `W` -> `LEG_WAVE` (6.0s)
- `S` -> `SHAKE` (6.0s)
- `D` -> `DANCE` (8.0s)
- `X` -> `STOP` (immediate)
- `Q` -> `QUIT`

### 3. Camera Capture Test
Verifies laptop webcam functionality via OpenCV:
```bash
python scripts/test_camera.py --camera 0
```

### 4. LiDAR Scan Test
Verifies RPLiDAR serial connectivity (when hardware is connected):
```bash
python scripts/test_lidar.py COM3 --baudrate 115200
```

---

## Configuration

All thresholds, durations, and device ports are configured centrally in `config/default.yaml`:

- `camera`: Device index, resolution, framerate, and horizontal FOV.
- `detection`: Detector backend (`hog`), confidence threshold, window stride, scale.
- `tracking`: IoU threshold, maximum track age, target loss timeout.
- `approach`: Preferred distance, minimum distance, maximum distance, horizontal tolerance, emergency stop threshold.
- `motions`: Explicit durations for `forward`, `backward`, `turn_left`, `turn_right`, `leg_wave`, `shake`, and `dance` (5–10s range).
- `lidar`: Serial port, baudrate, range boundaries, and sector tolerance.
- `transport`: Connection type (`console`, `serial`, `tcp`) and repeat interval.
