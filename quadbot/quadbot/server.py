"""FastAPI server: serves the dashboard and runs the control loop.

Run on the Pi:   python -m quadbot.server --config config/robot.yaml --host 0.0.0.0
Run on a laptop: python -m quadbot.server            (mock servos + mock lidar)

There is no login. Anyone who can reach the port can drive the robot, so only run it
on a network you trust (your own hotspot or router), and keep a hand near the e-stop.
"""
import argparse
import asyncio
import contextlib
import copy
import json
import logging
import time
from pathlib import Path

import numpy as np
import uvicorn
from fastapi import FastAPI, WebSocket, WebSocketDisconnect
from fastapi import FastAPI, Request, WebSocket, WebSocketDisconnect
from fastapi.responses import JSONResponse
from fastapi.staticfiles import StaticFiles

from . import config as cfgmod
from .battery import make_battery_reader
from .hal import make_driver
from .lidar import make_lidar
from .robot import Robot

log = logging.getLogger("quadbot")
ROOT = Path(__file__).resolve().parent.parent


def create_app(cfg_path=None, driver=None, lidar=None, battery=None, demo=False):
    cfg_path = Path(cfg_path or ROOT / "config" / "robot.yaml")
    cfg = cfgmod.load(cfg_path)
    if demo:
        cfg = copy.deepcopy(cfg)
        cfg["driver"] = "mock"
        cfg.setdefault("lidar", {})["driver"] = "mock"
        cfg.setdefault("battery", {})["driver"] = "mock"
    driver = driver or make_driver(cfg)
    lidar = lidar or make_lidar(cfg)
    battery = battery or make_battery_reader(cfg)
    robot = Robot(cfg, cfg_path, driver, lidar, battery=battery)
    clients = set()
    rate = cfg["control"]["rate_hz"]

    async def control_loop():
        last = time.monotonic()
        while True:
            await asyncio.sleep(1.0 / rate)
            now = time.monotonic()
            dt, last = min(now - last, 0.1), now
            try:
                robot.tick(dt)
            except Exception:                      # any control fault -> fail safe
                log.exception("control tick failed, triggering e-stop")
                robot.trigger_estop()

    async def broadcast(payload):
        text = json.dumps(payload)
        for ws in list(clients):
            try:
                await ws.send_text(text)
            except Exception:
                clients.discard(ws)

    async def state_loop():
        while True:
            await asyncio.sleep(0.05)
            if clients:
                await broadcast(robot.state_message())

    async def scan_loop():
        while True:
            await asyncio.sleep(0.125)
            if clients:
                scan, age = lidar.snapshot()
                await broadcast({"t": "scan", "d": np.round(scan).astype(int).tolist(), "age": round(age, 2)})

    @contextlib.asynccontextmanager
    async def lifespan(app):
        lidar.start()
        robot.start_imu()
        tasks = [asyncio.create_task(f()) for f in (control_loop, state_loop, scan_loop)]
        yield
        for t in tasks:
            t.cancel()
        lidar.stop()
        if battery:
            battery.close()
        robot.close_imu()
        robot.trigger_estop()
        driver.close()

    app = FastAPI(lifespan=lifespan)
    app.state.robot = robot

    @app.get("/api/config")
    def get_config():
        return JSONResponse(robot.cal_message())

    @app.post("/api/palm")
    async def palm_event(request: Request):
        payload = await request.json()
        robot.handle({"t": "palm", "detected": payload.get("detected", False)})
        return {"ok": True, "wave": robot.mode == "wave"}

    @app.websocket("/ws")
    async def ws_endpoint(ws: WebSocket):
        await ws.accept()
        clients.add(ws)
        await ws.send_text(json.dumps(robot.cal_message()))
        try:
            while True:
                msg = json.loads(await ws.receive_text())
                if msg.get("t") == "get_cal":
                    await ws.send_text(json.dumps(robot.cal_message()))
                else:
                    try:
                        robot.handle(msg)
                    except (KeyError, ValueError, TypeError) as e:     # a bad message must not drop the controller
                        log.warning("ignored bad message %r: %r", msg, e)
                        robot.notice = f"Ignored a malformed command ({msg.get('t')})"
        except (WebSocketDisconnect, json.JSONDecodeError):
            pass
        finally:
            clients.discard(ws)
            if not clients:
                robot.cmd = (0.0, 0.0, 0.0)     # last controller left: stop driving

    app.mount("/", StaticFiles(directory=ROOT / "web", html=True), name="web")
    return app


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--config", default=str(ROOT / "config" / "robot.yaml"))
    ap.add_argument("--host", default="0.0.0.0")
    ap.add_argument("--port", type=int, default=8000)
    ap.add_argument("--demo", action="store_true", help="Use mock servos, lidar, and battery")
    args = ap.parse_args()
    logging.basicConfig(level=logging.INFO)
    uvicorn.run(create_app(args.config, demo=args.demo), host=args.host, port=args.port, log_level="info")
    uvicorn.run(create_app(args.config), host=args.host, port=args.port, log_level="info")


if __name__ == "__main__":
    main()
