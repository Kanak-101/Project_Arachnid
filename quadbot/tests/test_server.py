import shutil
from pathlib import Path

from fastapi.testclient import TestClient

from quadbot.server import create_app

CFG = Path(__file__).resolve().parent.parent / "config" / "robot.yaml"


def make_app(tmp_path):
    p = tmp_path / "robot.yaml"
    shutil.copy(CFG, p)
    return create_app(cfg_path=p)


def wait_for(ws, pred, limit=120):
    for _ in range(limit):
        m = ws.receive_json()
        if pred(m):
            return m
    raise AssertionError("expected message never arrived")


def test_dashboard_and_config_are_served(tmp_path):
    with TestClient(make_app(tmp_path)) as c:
        r = c.get("/")
        assert r.status_code == 200 and "quadbot" in r.text
        assert c.get("/app.js").status_code == 200 and c.get("/style.css").status_code == 200
        cfg = c.get("/api/config").json()
        assert len(cfg["servos"]) == 12 and cfg["pulse_abs"] == [500, 2500]


def test_websocket_arm_enable_jog_and_estop(tmp_path):
    app = make_app(tmp_path)
    robot = app.state.robot
    with TestClient(app) as c, c.websocket_connect("/ws") as ws:
        assert ws.receive_json()["t"] == "cal"
        ws.send_json({"t": "arm", "on": True})
        ws.send_json({"t": "servo_enable", "id": "FL_coxa", "on": True})
        ws.send_json({"t": "servo_us", "id": "FL_coxa", "us": 1700})
        m = wait_for(ws, lambda m: m["t"] == "state" and m["live"]["FL_coxa"]["en"] and m["live"]["FL_coxa"]["us"] == 1700)
        assert m["armed"] and robot.driver.pulses[0] == 1700
        wait_for(ws, lambda m: m["t"] == "scan")
        ws.send_json({"t": "estop"})
        m = wait_for(ws, lambda m: m["t"] == "state" and m["estop"])
        assert not m["armed"] and robot.driver.pulses == {}


def test_calibration_change_bumps_version_and_client_can_refetch(tmp_path):
    app = make_app(tmp_path)
    with TestClient(app) as c, c.websocket_connect("/ws") as ws:
        v0 = ws.receive_json()["version"]
        ws.send_json({"t": "servo_cal", "id": "FR_tibia", "field": "invert", "value": True})
        m = wait_for(ws, lambda m: m["t"] == "state" and m["cal_version"] > v0)
        ws.send_json({"t": "get_cal"})
        cal = wait_for(ws, lambda m: m["t"] == "cal")
        assert next(s for s in cal["servos"] if s["id"] == "FR_tibia")["invert"] is True


def test_last_client_leaving_zeroes_the_drive_command(tmp_path):
    app = make_app(tmp_path)
    with TestClient(app) as c:
        with c.websocket_connect("/ws") as ws:
            ws.receive_json()
            ws.send_json({"t": "drive", "vx": 1, "vy": 0, "wz": 0})
            wait_for(ws, lambda m: m["t"] == "state" and m["cmd"][0] == 1.0)
        for _ in range(50):
            if app.state.robot.cmd == (0.0, 0.0, 0.0):
                break
            import time; time.sleep(0.02)
        assert app.state.robot.cmd == (0.0, 0.0, 0.0)


def test_malformed_message_does_not_kill_the_connection(tmp_path):
    with TestClient(make_app(tmp_path)) as c, c.websocket_connect("/ws") as ws:
        ws.receive_json()
        ws.send_json({"t": "servo_us", "id": "nope", "us": 1})
        ws.send_json({"t": "mode", "mode": "flying"})
        ws.send_json({"t": "arm", "on": True})
        wait_for(ws, lambda m: m["t"] == "state" and m["armed"])
