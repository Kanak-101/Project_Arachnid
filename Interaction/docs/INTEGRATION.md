# Project Arachnid Interaction Integration

This module is the laptop-side perception and behavior layer for Project Arachnid (`Kanak-101/Project_Arachnid`).

It runs on a local computer and connects to the existing robot controller without modifying low-level gait generation, inverse kinematics, or servo PWM signals.

## System Boundary

```text
[Laptop: Interaction Module]
  - Camera acquisition & OpenCV HOG pedestrian detection
  - RPLiDAR spatial candidate clustering & sensor fusion
  - Single-target selection & locking
  - Approach navigation decisions (5–10s durations)
  - Hand-wave gesture detection (multi-frame)
  - High-level motion command generation
            │
            ▼ TCP (port 5000) or USB Serial
[RPi 4B / Controller: Project Arachnid Controller]
  - arachnid_server.py (TCP server on 0.0.0.0:5000)
  - gait_engine.py (tripod gait, IK, single-leg motion)
  - servo_driver.py (PCA9685 I2C boards)
```

## Controller Protocol Integration

The Project Arachnid controller (`Controller/arachnid_server.py`) operates a TCP command server on port `5000`. The interaction module's `ArachnidServerTransport` maps high-level interaction commands directly to the controller's native commands:

| Interaction Command | Duration | Translated Controller Command |
| :--- | :--- | :--- |
| `FORWARD` | 5.0 s | `{"cmd": "WALK", "dx": 0.030, "dy": 0.0, "dyaw": 0.0}` |
| `BACKWARD` | 5.0 s | `{"cmd": "WALK", "dx": -0.030, "dy": 0.0, "dyaw": 0.0}` |
| `TURN_LEFT` | 5.0 s | `{"cmd": "WALK", "dx": 0.0, "dy": 0.0, "dyaw": 0.20}` |
| `TURN_RIGHT` | 5.0 s | `{"cmd": "WALK", "dx": 0.0, "dy": 0.0, "dyaw": -0.20}` |
| `STOP` | 0.0 s | `{"cmd": "STAND"}` |
| `LEG_WAVE` | 6.0 s | `{"cmd": "LEG", "leg": 1, "dx": 0.0, "dy": 0.0, "dz": -0.030}` |
| `SHAKE` | 6.0 s | `{"cmd": "SHAKE", "duration_s": 6.0}` |
| `DANCE` | 8.0 s | `{"cmd": "DANCE", "duration_s": 8.0}` |

If the controller has not yet implemented choreography for `DANCE` or `SHAKE`, it acknowledges the command without crashing, allowing gait engineers to map the motion to physical kinematics.

## Running Modes

### 1. Console Development (Safe / Default)
```bash
python -m arachnid_interaction --transport console
```
Prints all decisions and structured commands to stdout without communicating over the network.

### 2. Live Robot Connection (TCP to RPi)
```bash
python -m arachnid_interaction --transport arachnid
```
Connects to `arachnid_server.py` at the configured RPi IP (default `192.168.0.100:5000`).

### 3. Manual Keyboard Control
```bash
python scripts/manual_control.py --transport console
```
Key mapping:
- `W`: `LEG_WAVE` (6.0s)
- `S`: `SHAKE` (6.0s)
- `D`: `DANCE` (8.0s)
- `X`: `STOP` (immediate)
- `Q`: `QUIT`
