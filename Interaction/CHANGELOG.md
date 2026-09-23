# Changelog

All notable changes to the Project Arachnid Human Interaction Feature are documented in this file.

## [1.0.0] - 2026-09-20

### Added
- **OpenCV HOG Human Detection**: Default practical pedestrian detector using `cv2.HOGDescriptor` and `cv2.HOGDescriptor_getDefaultPeopleDetector()`. Eliminates mandatory deep learning dependencies.
- **RPLiDAR Spatial Candidate Extraction & Fusion**:
  - `navigation/lidar.py`: Cluster detection from 360° point cloud scans.
  - `navigation/fusion.py`: Camera-to-LiDAR bearing association and sector distance matching.
  - `search.py`: Spatial exploration correlating candidate bearings with camera human confirmation.
- **Single Target Selection & Locking**:
  - Deterministic target prioritization (`perception/select.py`) using LiDAR confirmation, distance, center alignment, and bounding box area.
  - Strict target lock maintaining focus on selected human and ignoring all other detected persons until target loss timeout.
- **Approach Controller with 5–10s Motion Durations**:
  - Configurable approach parameters (1.3m to 1.7m interaction range, 80px horizontal alignment tolerance).
  - Continuous movement commands configured with 5.0s durations (`FORWARD`, `BACKWARD`, `TURN_LEFT`, `TURN_RIGHT`).
  - Emergency proximity stop (`0.45m`) for collision prevention.
- **High-Level Interaction Motions**:
  - Whole-body arrival shake: `SHAKE` with 6.0s duration upon reaching interaction range.
  - Human wave detection: `perception/hand_wave.py` detecting multi-frame alternating horizontal hand movements for the locked target only.
  - One-leg response wave: `LEG_WAVE` with 6.0s duration.
  - Six-leg dance routine: `DANCE` with 8.0s duration.
- **Laptop Manual Control Interface**:
  - `scripts/manual_control.py` mapped to `W` (LEG_WAVE), `S` (SHAKE), `D` (DANCE), `X` (STOP), `Q` (QUIT).
  - Multi-transport support (`console`, `serial`, `tcp`).
- **Comprehensive Automated Test Suite**:
  - 42 deterministic unit tests covering target selection, target locking, state machine transitions, approach navigation, LiDAR clustering, fusion, gesture detection, motion durations, and safety limits.

