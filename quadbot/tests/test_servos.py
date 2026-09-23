from quadbot.servos import AutoDerate, ServoCal, SlewLimiter


def servo(**kw):
    d = dict(id="FL_coxa", leg="FL", joint="coxa", model="MG958", channel=0,
             us_min=500, us_max=2500, us_center=1500, us_per_deg=10.0)
    d.update(kw)
    return ServoCal(**d)


def test_deg_us_round_trip_and_invert():
    s = servo()
    assert s.deg_to_us(10) == 1600 and s.us_to_deg(1600) == 10
    s.invert = True
    assert s.deg_to_us(10) == 1400 and s.us_to_deg(1400) == 10


def test_zero_scale_loaded_from_saved_config_gets_safe_fallback():
    s = ServoCal.from_dict({
        "id": "FL_coxa", "leg": "FL", "joint": "coxa", "model": "MG958", "channel": 0,
        "us_min": 500, "us_max": 2500, "us_center": 1500, "us_per_deg": 0,
    })
    assert s.us_per_deg == 2000 / 180


def test_pulse_is_clamped_to_hard_limits():
    s = servo(us_min=600, us_max=2400)
    assert s.deg_to_us(500) == 2400 and s.deg_to_us(-500) == 600


def test_deg_range_respects_pulse_and_soft_limits():
    s = servo(us_min=1000, us_max=2000, deg_min=-30, deg_max=90)
    lo, hi = s.deg_range()
    assert lo == -30 and hi == 50


def test_slew_limiter_caps_speed_and_reports_saturation():
    s = servo(max_speed_dps=100)
    lim = SlewLimiter()
    lim.reset(s.id, 0.0)
    out = lim.step(s, 50.0, 0.1)             # wants 50 deg in 0.1 s; allowed 10
    assert abs(out - 10.0) < 1e-9
    for _ in range(30):
        lim.step(s, 50.0, 0.1)
    assert lim.cur[s.id] == 50.0
    assert lim.sat[s.id] < 0.5               # saturation decays once it arrives


def test_slew_limiter_clamps_target_and_flags_it():
    s = servo(us_min=1000, us_max=2000)      # +-50 deg
    lim = SlewLimiter()
    lim.reset(s.id, 0.0)
    for _ in range(200):
        lim.step(s, 80.0, 0.05)
    assert abs(lim.cur[s.id] - 50.0) < 1e-6 and lim.clamp[s.id] > 0.9


def test_auto_derate_slows_then_recovers():
    d = AutoDerate()
    for _ in range(100):
        d.update(0.5, 0.05)
    assert d.scale < 0.6
    low = d.scale
    for _ in range(4000):
        d.update(0.0, 0.05)
    assert d.scale > low and d.scale <= 1.0
    d2 = AutoDerate()
    d2.update(0.9, 1.0, active=False)
    assert d2.scale == 1.0
