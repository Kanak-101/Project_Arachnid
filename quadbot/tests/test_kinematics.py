import math
import random

from quadbot.kinematics import LegKinematics

K = LegKinematics(40, 80, 120)


def test_fk_of_neutral_pose():
    x, y, z = K.fk(0, 0, 0)          # coxa out, femur horizontal, tibia vertical
    assert math.isclose(x, 120, abs_tol=1e-6) and math.isclose(y, 0, abs_tol=1e-6)
    assert math.isclose(z, -120, abs_tol=1e-6)


def test_ik_fk_round_trip_over_workspace():
    random.seed(1)
    n = 0
    for _ in range(2000):
        th = math.radians(random.uniform(-60, 60))
        r = random.uniform(70, 190)
        x, y, z = r * math.cos(th), r * math.sin(th), random.uniform(-150, -20)
        a, b, c, ok = K.ik(x, y, z)
        if not ok:
            continue
        n += 1
        fx, fy, fz = K.fk(a, b, c)
        assert math.dist((x, y, z), (fx, fy, fz)) < 1e-6
    assert n > 500


def test_unreachable_is_flagged_and_finite():
    a, b, c, ok = K.ik(400, 0, -50)
    assert not ok and all(math.isfinite(v) for v in (a, b, c))


def test_knee_is_up_solution():
    # for a low foot the femur must point up relative to the line to the foot, not fold under
    a, b, c, ok = K.ik(120, 0, -90)
    assert ok and b > 0
