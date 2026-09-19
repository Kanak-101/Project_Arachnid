from __future__ import annotations

import argparse
import logging
import sys
import time
from pathlib import Path
from typing import Any, Optional, Union

import cv2
import numpy as np

from .behavior.motions import MotionConfig
from .behavior.state_machine import InteractionStateMachine, State
from .commands import Command, MotionCommand
from .config import load_config
from .control.transport import create_transport
from .navigation.approach import ApproachController
from .navigation.fusion import associate_camera_and_lidar, camera_x_to_bearing
from .navigation.lidar import LidarReader
from .perception.camera import Camera
from .perception.hand_wave import Gesture, MediaPipeHandAdapter, WaveDetector
from .perception.person_detector import PersonDetector
from .perception.select import TargetSelector, select_target
from .perception.tracker import IoUTracker
from .search import SpatialSearcher

logger = logging.getLogger("arachnid_interaction")


def parse_camera_source(value: Any) -> Union[int, str]:
    try:
        return int(value)
    except (TypeError, ValueError):
        return str(value)


def run(
    config_path: str,
    camera_source: Optional[Union[int, str]] = None,
    enable_lidar: Optional[bool] = None,
    transport: Optional[str] = None,
    max_iterations: Optional[int] = None,
) -> None:
    """Run the Project Arachnid human interaction runtime loop."""
    cfg = load_config(config_path)

    cam_cfg = cfg.get("camera", {})
    det_cfg = cfg.get("detection", {})
    track_cfg = cfg.get("tracking", {})
    nav_cfg = cfg.get("approach", cfg.get("navigation", {}))
    motion_cfg = cfg.get("motions", cfg.get("motion", {}))
    gesture_cfg = cfg.get("gesture", {})
    transport_cfg = dict(cfg.get("transport", {}))
    if transport is not None:
        transport_cfg["type"] = transport

    # Camera resolution and source
    cam_index = cam_cfg.get("index", cam_cfg.get("source", 0))
    src = parse_camera_source(cam_index if camera_source is None else camera_source)
    camera = Camera(
        source=src,
        width=int(cam_cfg.get("width", 1280)),
        height=int(cam_cfg.get("height", 720)),
        fps=int(cam_cfg.get("fps", 30)),
    )

    # OpenCV HOG detector by default
    detector = PersonDetector(
        model_or_type=det_cfg.get("detector_type", "hog"),
        confidence=float(det_cfg.get("confidence", 0.0)),
        win_stride=tuple(det_cfg.get("win_stride", [8, 8])),
        padding=tuple(det_cfg.get("padding", [8, 8])),
        scale=float(det_cfg.get("scale", 1.05)),
    )

    tracker = IoUTracker(
        iou_threshold=float(track_cfg.get("iou_threshold", 0.30)),
        max_age_frames=int(track_cfg.get("max_track_age_frames", 20)),
    )

    target_selector = TargetSelector(
        target_timeout_s=float(track_cfg.get("target_timeout_s", 3.0))
    )

    hands = MediaPipeHandAdapter(
        min_detection_confidence=float(gesture_cfg.get("hand_confidence", 0.50))
    )
    wave = WaveDetector(
        history_frames=int(gesture_cfg.get("history_frames", 8)),
        min_range_px=float(gesture_cfg.get("wave_min_range_px", 35.0)),
        min_direction_changes=int(gesture_cfg.get("wave_min_direction_changes", 2)),
    )

    approach = ApproachController(
        horizontal_tolerance_px=int(nav_cfg.get("horizontal_tolerance_px", 80)),
        minimum_distance_m=float(nav_cfg.get("minimum_distance_m", 1.30)),
        maximum_distance_m=float(nav_cfg.get("maximum_distance_m", 1.70)),
        preferred_distance_m=float(nav_cfg.get("preferred_distance_m", 1.50)),
        emergency_stop_m=float(nav_cfg.get("emergency_stop_m", 0.45)),
        forward_duration_s=float(motion_cfg.get("forward_duration_s", 5.0)),
        backward_duration_s=float(motion_cfg.get("backward_duration_s", 5.0)),
        turn_left_duration_s=float(motion_cfg.get("turn_left_duration_s", 5.0)),
        turn_right_duration_s=float(motion_cfg.get("turn_right_duration_s", 5.0)),
    )

    motion = MotionConfig(
        forward_duration_s=float(motion_cfg.get("forward_duration_s", 5.0)),
        backward_duration_s=float(motion_cfg.get("backward_duration_s", 5.0)),
        turn_left_duration_s=float(motion_cfg.get("turn_left_duration_s", 5.0)),
        turn_right_duration_s=float(motion_cfg.get("turn_right_duration_s", 5.0)),
        leg_wave_duration_s=float(motion_cfg.get("leg_wave_duration_s", 6.0)),
        shake_duration_s=float(motion_cfg.get("shake_duration_s", 6.0)),
        dance_duration_s=float(motion_cfg.get("dance_duration_s", 8.0)),
        wave_leg=int(cfg.get("interaction", {}).get("leg_wave_leg", 1)),
    )

    sink = create_transport(transport_cfg)
    machine = InteractionStateMachine(
        sink=sink,
        approach=approach,
        motion=motion,
        target_timeout_s=float(track_cfg.get("target_timeout_s", 3.0)),
        gesture_cooldown_s=float(gesture_cfg.get("cooldown_s", 2.0)),
    )

    fov_deg = float(cam_cfg.get("horizontal_fov_deg", 62.0))
    searcher = SpatialSearcher(horizontal_fov_deg=fov_deg)

    # Optional RPLiDAR
    lidar: Optional[LidarReader] = None
    lidar_cfg = cfg.get("lidar", {})
    lidar_enabled = lidar_cfg.get("enabled", False) if enable_lidar is None else enable_lidar
    if lidar_enabled:
        try:
            lidar = LidarReader(
                port=str(lidar_cfg.get("port", "COM3")),
                baudrate=int(lidar_cfg.get("baudrate", 115200)),
                min_range_m=float(lidar_cfg.get("min_range_m", 0.4)),
                max_range_m=float(lidar_cfg.get("max_range_m", 8.0)),
            )
            lidar.start()
        except Exception as exc:
            logger.warning("LiDAR failed to start, falling back to camera-only mode: %s", exc)
            lidar = None

    iterations = 0
    try:
        while True:
            if max_iterations is not None and iterations >= max_iterations:
                break
            iterations += 1

            frame = camera.read()
            h, w = frame.shape[:2]
            center_x = w / 2.0

            # 1. OpenCV Human Detection
            detections = detector.detect(frame)

            # 2. Track people across frames
            people = tracker.update(detections)

            # 3. Process LiDAR candidates if available
            candidates = []
            lidar_associated_ids = set()
            candidate_distances = {}
            if lidar is not None:
                candidates = lidar.extract_candidates()
                _fused, lidar_associated_ids, candidate_distances = associate_camera_and_lidar(
                    people=people,
                    candidates=candidates,
                    image_center_x=center_x,
                    horizontal_fov_deg=fov_deg,
                    sector_tolerance_deg=float(lidar_cfg.get("sector_deg", 8.0)),
                )

            # 4. Target Selection / Locking
            if machine.target_id is None:
                # SEARCHING: Evaluate spatial candidates and camera confirmation
                search_res = searcher.evaluate(candidates, people, center_x)
                if search_res.confirmed_target_id is not None:
                    machine.set_target(search_res.confirmed_target_id)
                elif search_res.suggested_motion is not None:
                    sink.send(search_res.suggested_motion)
            else:
                # Check if locked target is still tracked
                active_target = next((p for p in people if p.track_id == machine.target_id), None)
                if active_target is None:
                    # Let state machine track timeout and clear if expired
                    pass

            # 5. Measure distance and watch gesture for LOCKED target only
            locked_target = next((p for p in people if p.track_id == machine.target_id), None)
            distance_m = None
            gesture = Gesture.NONE

            if locked_target is not None:
                # LiDAR distance for locked target
                if locked_target.track_id in candidate_distances:
                    distance_m = candidate_distances[locked_target.track_id]
                elif lidar is not None:
                    target_bearing = camera_x_to_bearing(locked_target.center_x, center_x, fov_deg)
                    distance_m = lidar.distance_at(
                        target_bearing % 360.0, sector_deg=float(lidar_cfg.get("sector_deg", 8.0))
                    )

                # Hand wave detection on locked target's bounding box only
                wrist = hands.wrist_for_box(frame, locked_target.bbox)
                gesture = wave.update(wrist)
            else:
                wave.reset()

            # 6. Step Behavior State Machine
            machine.update(
                people=people,
                image_center_x=center_x,
                distance_m=distance_m,
                gesture=gesture,
                gesture_person_id=machine.target_id,
            )

            # 7. Visualization
            PersonDetector.draw(frame, people, machine.target_id)

            status = f"STATE: {machine.state.value}"
            if machine.target_id is not None:
                status += f" | LOCKED TARGET: {machine.target_id}"
            if distance_m is not None:
                status += f" | DIST: {distance_m:.2f}m"
            if gesture is not Gesture.NONE:
                status += f" | GESTURE: {gesture.value}"
            cv2.putText(frame, status, (16, 30), cv2.FONT_HERSHEY_SIMPLEX, 0.65, (0, 255, 255), 2)
            cv2.putText(
                frame,
                "Q: quit | R: release target | W: leg-wave | S: shake | D: dance",
                (16, h - 16),
                cv2.FONT_HERSHEY_SIMPLEX,
                0.52,
                (200, 200, 200),
                1,
            )

            try:
                cv2.imshow("Project Arachnid - Human Interaction", frame)
                key = cv2.waitKey(1) & 0xFF
                if key == ord("q"):
                    break
                elif key == ord("r"):
                    machine.clear_target()
                elif key == ord("w"):
                    machine.trigger_leg_wave()
                elif key == ord("s"):
                    machine.trigger_shake()
                elif key == ord("d"):
                    machine.trigger_dance()
            except cv2.error:
                # Running headless / without display
                pass

            time.sleep(0.001)
    finally:
        machine.clear_target()
        if lidar is not None:
            lidar.stop()
        hands.close()
        camera.release()
        sink.close()
        try:
            cv2.destroyAllWindows()
        except cv2.error:
            pass


def main() -> None:
    parser = argparse.ArgumentParser(description="Project Arachnid laptop-side Human Interaction")
    default_config = Path(__file__).resolve().parents[2] / "config" / "default.yaml"
    parser.add_argument("--config", default=str(default_config), help="Path to default.yaml")
    parser.add_argument("--camera", default=None, help="Camera index or OpenCV device source")
    parser.add_argument("--lidar", action="store_true", help="Force-enable RPLiDAR")
    parser.add_argument("--no-lidar", action="store_true", help="Force-disable RPLiDAR")
    parser.add_argument("--transport", choices=("console", "serial", "tcp"), default=None)
    args = parser.parse_args()

    lidar_override = True if args.lidar else (False if args.no_lidar else None)
    run(
        config_path=args.config,
        camera_source=args.camera,
        enable_lidar=lidar_override,
        transport=args.transport,
    )


if __name__ == "__main__":
    main()
