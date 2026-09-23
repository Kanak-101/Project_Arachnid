from __future__ import annotations

from arachnid_interaction.navigation.lidar import LidarCandidate, LidarReader


def test_lidar_distance_at_bearing():
    reader = LidarReader(port="TEST", min_range_m=0.4, max_range_m=8.0)
    # Feed points around 0 degrees (front), 90 degrees (right), 270 degrees (left)
    points = [
        (0.0, 1.50),
        (2.0, 1.52),
        (358.0, 1.48),
        (90.0, 2.80),
        (92.0, 2.85),
        (270.0, 0.80),
    ]
    reader.feed_points(points)

    front = reader.distance_at(0.0, sector_deg=8.0)
    assert front is not None
    assert 1.45 <= front <= 1.55

    right = reader.distance_at(90.0, sector_deg=8.0)
    assert right is not None
    assert 2.75 <= right <= 2.90

    # Bearing with no points in sector
    empty = reader.distance_at(180.0, sector_deg=8.0)
    assert empty is None


def test_lidar_filters_out_of_range_points():
    reader = LidarReader(port="TEST", min_range_m=0.5, max_range_m=5.0)
    # Point at 0.2m (too close) and 7.0m (too far)
    reader.feed_points([(0.0, 0.20), (0.0, 7.00), (0.0, 2.00)])
    dist = reader.distance_at(0.0, sector_deg=10.0)
    assert dist == 2.00


def test_lidar_candidate_clustering():
    reader = LidarReader(port="TEST", min_range_m=0.4, max_range_m=8.0)
    # Cluster 1: front at ~1.5m
    cluster_1 = [(0.0, 1.5), (2.0, 1.52), (3.0, 1.49), (4.0, 1.51)]
    # Cluster 2: right at ~3.0m
    cluster_2 = [(88.0, 3.0), (89.0, 3.02), (90.0, 2.98), (91.0, 3.01)]
    reader.feed_points(cluster_1 + cluster_2)

    candidates = reader.extract_candidates(
        cluster_angle_thresh_deg=6.0,
        cluster_dist_thresh_m=0.3,
        min_cluster_points=3,
    )
    assert len(candidates) == 2

    # Check candidate bearings and ranges
    bearings = [c.bearing_deg for c in candidates]
    assert any(abs(b - 2.25) < 1.0 or abs(b - 0.0) < 5.0 for b in bearings)
    assert any(abs(b - 89.5) < 2.0 for b in bearings)

