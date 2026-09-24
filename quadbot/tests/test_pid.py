from quadbot.pid import PID


def test_pid_is_bounded_and_integral_is_anti_windup():
    pid = PID(kp=2, ki=1, kd=0, output_limit=5, integral_limit=2)
    for _ in range(100):
        assert pid.update(10, 0.02) == 5
    assert pid.integral <= 2
    assert pid.update(-10, 0.02) < 5


def test_pid_derivative_reacts_to_error_change():
    pid = PID(kp=0, ki=0, kd=1, output_limit=100)
    pid.update(0, 0.1)
    assert pid.update(5, 0.1) == 50