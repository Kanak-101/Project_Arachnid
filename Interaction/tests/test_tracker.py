from arachnid_interaction.perception.tracker import IoUTracker
from arachnid_interaction.perception.types import BoundingBox, Person


def test_track_id_persists_for_overlapping_detection():
    tracker = IoUTracker(iou_threshold=0.2)
    first = tracker.update([Person(-1, BoundingBox(100, 100, 200, 300), 0.9)])
    track_id = first[0].track_id
    second = tracker.update([Person(-1, BoundingBox(105, 105, 205, 305), 0.9)])
    assert second[0].track_id == track_id
