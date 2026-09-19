from __future__ import annotations

from arachnid_interaction.perception.hand_wave import Gesture, WaveDetector


def test_wave_requires_multiple_direction_changes():
    detector = WaveDetector(
        history_frames=8,
        min_range_px=20.0,
        min_direction_changes=2,
        deadband_px=2.0,
    )
    # Alternating motion: left-right-left
    points = [
        (20.0, 100.0),
        (40.0, 100.0),
        (60.0, 100.0),
        (40.0, 100.0),
        (20.0, 100.0),
        (40.0, 100.0),
        (60.0, 100.0),
        (40.0, 100.0),
    ]
    result = Gesture.NONE
    for pt in points:
        result = detector.update(pt)
    assert result is Gesture.WAVE


def test_static_raised_hand_is_not_a_wave():
    detector = WaveDetector(history_frames=8, min_range_px=20.0)
    # Stationary hand raised at (50, 50)
    points = [(50.0, 50.0)] * 10
    result = Gesture.NONE
    for pt in points:
        result = detector.update(pt)
    assert result is Gesture.NONE


def test_unidirectional_motion_is_not_a_wave():
    detector = WaveDetector(history_frames=8, min_range_px=20.0, min_direction_changes=2)
    # Hand moving in one direction only (no alternating reversal)
    points = [(float(x), 50.0) for x in range(10, 90, 10)]
    result = Gesture.NONE
    for pt in points:
        result = detector.update(pt)
    assert result is Gesture.NONE


def test_small_jitter_below_range_threshold_is_rejected():
    detector = WaveDetector(history_frames=8, min_range_px=35.0, min_direction_changes=2)
    # Jittering between 50 and 55 px (span = 5px < 35px)
    points = [(50.0 if i % 2 == 0 else 55.0, 100.0) for i in range(10)]
    result = Gesture.NONE
    for pt in points:
        result = detector.update(pt)
    assert result is Gesture.NONE


def test_reset_on_lost_hand():
    detector = WaveDetector(history_frames=8)
    detector.update((50.0, 100.0))
    result = detector.update(None)
    assert result is Gesture.NONE
    assert len(detector._history) == 0
