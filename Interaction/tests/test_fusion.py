from __future__ import annotations

from arachnid_interaction.navigation.fusion import (
    associate_camera_and_lidar,
    camera_x_to_bearing,
    normalize_angle_deg,
)
from arachnid_interaction.navigation.lidar import LidarCandidate
from arachnid_interaction.perception.types import BoundingBox, Person
from arachnid_interaction.search import SpatialSearcher


def make_person(track_id: int, center_x: float) -> Person:
    return Person(track_id, BoundingBox(int(center_x - 40), 100, int(center_x + 40), 300), 0.9)


def test_camera_x_to_bearing_conversion():
    # Image width 1280, optical center 640, horizontal FOV 60 deg
    assert camera_x_to_bearing(640, 640, 60.0) == 0.0
    # Far left (x=0) -> -30 deg
    assert camera_x_to_bearing(0, 640, 60.0) == -30.0
    # Far right (x=1280) -> +30 deg
    assert camera_x_to_bearing(1280, 640, 60.0) == 30.0


def test_bearing_normalization():
    assert normalize_angle_deg(0.0) == 0.0
    assert normalize_angle_deg(360.0) == 0.0
    assert normalize_angle_deg(270.0) == -90.0
    assert normalize_angle_deg(-190.0) == 170.0


def test_associate_camera_and_lidar_candidates():
    # Person 1 at center (0 deg bearing)
    # Person 2 at right (~15 deg bearing)
    people = [make_person(1, 640), make_person(2, 960)]

    # Candidates: one at 0.5 deg / 1.5m, one at 14.8 deg / 2.2m, one at 90 deg / 4.0m
    candidates = [
        LidarCandidate(bearing_deg=0.5, distance_m=1.50),
        LidarCandidate(bearing_deg=14.8, distance_m=2.20),
        LidarCandidate(bearing_deg=90.0, distance_m=4.00),
    ]

    fused, associated_ids, distances = associate_camera_and_lidar(
        people=people,
        candidates=candidates,
        image_center_x=640,
        horizontal_fov_deg=60.0,
        sector_tolerance_deg=5.0,
    )

    assert 1 in associated_ids
    assert 2 in associated_ids
    assert distances[1] == 1.50
    assert distances[2] == 2.20
    assert len(fused) == 2
    assert fused[0].lidar_associated is True
    assert fused[1].lidar_associated is True


def test_spatial_searcher_finds_confirmed_target():
    searcher = SpatialSearcher(horizontal_fov_deg=60.0)
    person = make_person(7, 640)
    candidate = LidarCandidate(bearing_deg=0.0, distance_m=1.60)

    result = searcher.evaluate([candidate], [person], image_center_x=640)
    assert result.confirmed_target_id == 7


def test_spatial_searcher_suggests_turn_for_off_camera_candidate():
    searcher = SpatialSearcher(horizontal_fov_deg=60.0, turn_duration_s=5.0)
    # Candidate at 270 deg (-90 deg, to the left outside camera FOV [-30, +30])
    candidate = LidarCandidate(bearing_deg=270.0, distance_m=2.0)

    result = searcher.evaluate([candidate], [], image_center_x=640)
    assert result.confirmed_target_id is None
    assert result.suggested_motion is not None
    assert result.suggested_motion.command.value == "TURN_LEFT"
    assert result.suggested_motion.duration_s == 5.0

