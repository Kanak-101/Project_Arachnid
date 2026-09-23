from __future__ import annotations

from arachnid_interaction.perception.select import TargetSelector, select_target
from arachnid_interaction.perception.types import BoundingBox, Person


def make_person(track_id: int, center_x: float, area: int = 10000, confidence: float = 0.9) -> Person:
    half = int((area ** 0.5) / 2)
    return Person(
        track_id=track_id,
        bbox=BoundingBox(int(center_x - half), 100, int(center_x + half), 100 + 2 * half),
        confidence=confidence,
    )


def test_multiple_people_selects_exactly_one_target():
    # Person A, Person B, Person C, Person D
    person_a = make_person(1, 200)
    person_b = make_person(2, 650)  # Near optical center (640)
    person_c = make_person(3, 900)
    person_d = make_person(4, 1100)

    selected = select_target([person_a, person_b, person_c, person_d], image_center_x=640)
    assert selected == 2


def test_lidar_association_prioritized():
    person_a = make_person(1, 640)  # Centered, but no lidar
    person_b = make_person(2, 680)  # Slightly offset, but has confirmed lidar

    selected = select_target(
        [person_a, person_b],
        image_center_x=640,
        lidar_associated_ids={2},
    )
    assert selected == 2


def test_closest_candidate_distance_prioritized():
    person_a = make_person(1, 650)
    person_b = make_person(2, 630)

    selected = select_target(
        [person_a, person_b],
        image_center_x=640,
        lidar_associated_ids={1, 2},
        candidate_distances={1: 1.5, 2: 3.2},
    )
    assert selected == 1


def test_target_lock_prevents_stealing_by_other_people():
    selector = TargetSelector(target_timeout_s=3.0)

    person_a = make_person(1, 300)
    person_b = make_person(2, 640)
    person_c = make_person(3, 800)

    # Initial frame: Person B is selected and locked
    locked_id = selector.update([person_a, person_b, person_c], image_center_x=640, now=100.0)
    assert locked_id == 2
    assert selector.is_locked

    # Next frame: Person D appears directly in front with large size, but B is still visible
    person_d = make_person(4, 640, area=40000, confidence=0.99)
    locked_id = selector.update([person_a, person_b, person_c, person_d], image_center_x=640, now=101.0)

    # Target locking ensures Person D cannot steal the target while Person B is locked
    assert locked_id == 2


def test_target_released_after_timeout():
    selector = TargetSelector(target_timeout_s=3.0)

    person_b = make_person(2, 640)
    selector.update([person_b], image_center_x=640, now=100.0)
    assert selector.target_id == 2

    # Target missing, but within timeout
    selector.update([], image_center_x=640, now=102.0)
    assert selector.target_id == 2

    # Target missing beyond timeout -> released
    selector.update([], image_center_x=640, now=104.0)
    assert selector.target_id is None
    assert not selector.is_locked
