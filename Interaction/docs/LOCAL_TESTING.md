# Local Laptop Testing Guide

This guide describes how to run and verify the interaction layer on a development laptop without physical hardware attached.

## 1. Environment Setup

From the `Project_Arachnid/Interaction/` directory:

```bash
python -m venv .venv
```

Activate environment:
- Windows (PowerShell):
  ```powershell
  .\.venv\Scripts\Activate.ps1
  ```
- Linux / macOS:
  ```bash
  source .venv/bin/activate
  ```

Install dependencies:
```bash
pip install -r requirements.txt
```

## 2. Automated Test Suite

Run pytest to verify perception, tracking, navigation, gesture detection, and safety rules:

```bash
pytest tests
```

Expected result: 43 passed with zero failures.

## 3. Motion Command Validation

Verify high-level motion command creation and 5–10s duration enforcement:

```bash
python scripts/test_motions.py
```

## 4. Camera Capture Test

Verify OpenCV camera access and frame capture:

```bash
python scripts/test_camera.py --camera 0
```
Press `Q` to exit.

## 5. Manual Control Test

Test keyboard control with safe console transport:

```bash
python scripts/manual_control.py --transport console
```

Keys:
- `W` -> `LEG_WAVE` (6.0s)
- `S` -> `SHAKE`    (6.0s)
- `D` -> `DANCE`    (8.0s)
- `X` -> `STOP`     (immediate)
- `Q` -> `QUIT`

## 6. Full Interactive Runtime

Launch the complete vision pipeline with camera capture and target tracking:

```bash
python -m arachnid_interaction --transport console
```

In console mode, all movement decisions and structured commands are displayed in the terminal and on the OpenCV video overlay without transmitting to physical hardware.
