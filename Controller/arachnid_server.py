"""
arachnid_server.py  –  Project Arachnid  (runs on RPi 4B)
TCP command server + sensor data streamer.

Protocol (plain JSON over TCP, newline-delimited):
  Client → Server:  { "cmd": "WALK",  "dx": 0.03, "dy": 0.0, "dyaw": 0.0 }
  Client → Server:  { "cmd": "LEG",   "leg": 2, "dx": 0.01, "dy": 0.0, "dz": 0.0 }
  Client → Server:  { "cmd": "STAND" }
  Client → Server:  { "cmd": "STOP"  }
  Client → Server:  { "cmd": "NEUTRAL" }
  Client → Server:  { "cmd": "ESTOP" }   ← emergency stop, goes limp

  Server → Client:  { sensor data JSON } every 100 ms (on same connection)

Usage:
  python3 arachnid_server.py

Ports:
  CMD_PORT   5000   (command + telemetry, same socket)
"""

import json
import socket
import threading
import time
import traceback

import sensor_node
import gait_engine
import servo_driver

CMD_PORT        = 5000
TELEMETRY_HZ    = 10      # sensor data pushes per second
TELEMETRY_INT   = 1.0 / TELEMETRY_HZ

# ── State ─────────────────────────────────────────────────────────────────────
_running       = True
_estop         = False
_mode          = 1          # 1 = full-body,  2 = single-leg
_selected_leg  = 1          # used in mode 2


def _handle_command(payload: dict) -> str:
    """
    Process one command dict.
    Returns a JSON string acknowledgement.
    """
    global _estop, _mode, _selected_leg

    cmd = payload.get("cmd", "").upper()

    if cmd == "ESTOP":
        _estop = True
        servo_driver.power_off()
        return json.dumps({"ack": "ESTOP", "status": "servos_off"})

    if _estop and cmd != "RESUME":
        return json.dumps({"ack": cmd, "status": "ESTOP_ACTIVE"})

    if cmd == "RESUME":
        _estop = False
        servo_driver.go_neutral()
        return json.dumps({"ack": "RESUME"})

    if cmd == "STAND":
        gait_engine.stand()
        return json.dumps({"ack": "STAND"})

    if cmd == "NEUTRAL":
        servo_driver.go_neutral()
        return json.dumps({"ack": "NEUTRAL"})

    if cmd == "STOP":
        return json.dumps({"ack": "STOP"})   # gait naturally stops after cycle

    if cmd == "SETMODE":
        _mode = int(payload.get("mode", 1))
        return json.dumps({"ack": "SETMODE", "mode": _mode})

    if cmd == "SELECTLEG":
        _selected_leg = int(payload.get("leg", 1))
        return json.dumps({"ack": "SELECTLEG", "leg": _selected_leg})

    if cmd == "WALK":
        dx   = float(payload.get("dx",   0.0))
        dy   = float(payload.get("dy",   0.0))
        dyaw = float(payload.get("dyaw", 0.0))
        # Run one tripod cycle in a thread so server stays responsive
        threading.Thread(
            target=gait_engine.walk,
            args=(dx, dy, dyaw, 1),
            daemon=True
        ).start()
        return json.dumps({"ack": "WALK", "dx": dx, "dy": dy, "dyaw": dyaw})

    if cmd == "LEG":
        leg = int(payload.get("leg", _selected_leg))
        dx  = float(payload.get("dx", 0.0))
        dy  = float(payload.get("dy", 0.0))
        dz  = float(payload.get("dz", 0.0))
        threading.Thread(
            target=gait_engine.step_single_leg,
            args=(leg, dx, dy, dz),
            daemon=True
        ).start()
        return json.dumps({"ack": "LEG", "leg": leg})

    if cmd == "JOINT":
        leg   = int(payload.get("leg", 1))
        joint = int(payload.get("joint", 1))
        angle = float(payload.get("angle_rad", 0.0))
        servo_driver.set_joint_rad(leg, joint, angle)
        return json.dumps({"ack": "JOINT", "leg": leg, "joint": joint})

    if cmd == "PING":
        return json.dumps({"ack": "PONG"})

    return json.dumps({"ack": "UNKNOWN", "cmd": cmd})


def _client_handler(conn: socket.socket, addr):
    """Handle one connected client: read commands, push telemetry."""
    print(f"[server] Client connected: {addr}")
    conn.settimeout(0.1)

    last_telem = 0.0

    try:
        buf = ""
        while _running:
            # ── Push telemetry ─────────────────────────────────────────────
            now = time.time()
            if now - last_telem >= TELEMETRY_INT:
                data = sensor_node.get_all()
                data["mode"]         = _mode
                data["selected_leg"] = _selected_leg
                line = json.dumps(data) + "\n"
                try:
                    conn.sendall(line.encode())
                except Exception:
                    break
                last_telem = now

            # ── Read commands (non-blocking) ───────────────────────────────
            try:
                chunk = conn.recv(1024).decode("utf-8", errors="ignore")
                if not chunk:
                    break
                buf += chunk
                while "\n" in buf:
                    line, buf = buf.split("\n", 1)
                    line = line.strip()
                    if not line:
                        continue
                    try:
                        payload = json.loads(line)
                        ack     = _handle_command(payload)
                        conn.sendall((ack + "\n").encode())
                    except json.JSONDecodeError as e:
                        conn.sendall(
                            json.dumps({"error": str(e)}).encode() + b"\n"
                        )
            except socket.timeout:
                pass

    except Exception as e:
        print(f"[server] Client {addr} error: {e}")
        traceback.print_exc()
    finally:
        conn.close()
        print(f"[server] Client {addr} disconnected.")


def main():
    print("=" * 50)
    print("  Project Arachnid — RPi Server")
    print("=" * 50)

    # Init hardware
    print("[boot] Initialising servos...")
    servo_driver.init_servos()
    servo_driver.go_neutral()

    print("[boot] Starting sensor threads...")
    sensor_node.start_all()

    print("[boot] Standing up...")
    time.sleep(1.0)
    gait_engine.stand()

    # TCP server
    srv = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    srv.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    srv.bind(("0.0.0.0", CMD_PORT))
    srv.listen(2)
    print(f"[server] Listening on 0.0.0.0:{CMD_PORT}")

    try:
        while _running:
            try:
                conn, addr = srv.accept()
                t = threading.Thread(
                    target=_client_handler,
                    args=(conn, addr),
                    daemon=True
                )
                t.start()
            except KeyboardInterrupt:
                break
    finally:
        print("[server] Shutting down...")
        servo_driver.power_off()
        srv.close()


if __name__ == "__main__":
    main()
