"""
arachnid_controller.py  –  Project Arachnid  (runs on your LAPTOP)
Keyboard controller with live telemetry display.

Requirements:
  pip install windows-curses   (Windows / WSL)
  or
  pip install curses           (Linux)

Key bindings:
  ── Mode 1: Full-body movement ──────────────────────────────────────────
  W / S          Forward / Backward
  A / D          Strafe Left / Strafe Right
  Q / E          Turn Left (CCW) / Turn Right (CW)
  SPACE          Stand (stop and go to home pose)
  N              Go to neutral (all joints centre)
  TAB            Switch to Mode 2 (single-leg)
  ESC            Emergency Stop (servos go limp)
  R              Resume from E-STOP

  ── Mode 2: Single-leg control ──────────────────────────────────────────
  1–6            Select active leg (1=FR, 2=R, 3=BR, 4=BL, 5=L, 6=FL)
  W / S          Move selected leg foot Forward / Backward
  A / D          Move selected leg foot Left / Right
  Z / X          Move selected leg foot Up / Down
  TAB            Switch back to Mode 1

  ── Any mode ────────────────────────────────────────────────────────────
  + / -          Increase / Decrease step size
  P              Ping server (latency check)
"""

import curses
import json
import socket
import threading
import time
import sys

# ── Connection settings ───────────────────────────────────────────────────────
RPI_IP   = "192.168.0.100"   # ← change to your RPi static IP
RPI_PORT = 5000

# ── Movement parameters ───────────────────────────────────────────────────────
STEP_M      = 0.030      # metres per keypress (body translation)
STEP_RAD    = 0.20       # radians per keypress (turn)
LEG_STEP_M  = 0.010      # metres per keypress (single leg)
LEG_STEP_Z  = 0.008      # metres up/down per keypress

# ── Shared state ──────────────────────────────────────────────────────────────
_telemetry   = {}
_telem_lock  = threading.Lock()
_sock        = None
_send_lock   = threading.Lock()
_connected   = False
_mode        = 1
_selected_leg = 1
_step_size   = 1.0       # multiplier
_latency_ms  = 0.0
_last_cmd    = ""


# ── Network ───────────────────────────────────────────────────────────────────
def _connect():
    global _sock, _connected
    while True:
        try:
            s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            s.connect((RPI_IP, RPI_PORT))
            s.settimeout(0.5)
            _sock      = s
            _connected = True
            print(f"[ctrl] Connected to {RPI_IP}:{RPI_PORT}")
            return
        except Exception as e:
            print(f"[ctrl] Connection failed: {e}. Retrying in 2s...")
            time.sleep(2)


def _recv_thread():
    global _telemetry, _connected
    buf = ""
    while True:
        try:
            if not _connected or _sock is None:
                time.sleep(0.1)
                continue
            try:
                chunk = _sock.recv(4096).decode("utf-8", errors="ignore")
                if not chunk:
                    _connected = False
                    continue
                buf += chunk
                while "\n" in buf:
                    line, buf = buf.split("\n", 1)
                    line = line.strip()
                    if not line:
                        continue
                    try:
                        data = json.loads(line)
                        with _telem_lock:
                            _telemetry = data
                    except json.JSONDecodeError:
                        pass
            except socket.timeout:
                pass
        except Exception as e:
            _connected = False
            time.sleep(0.5)


def send_cmd(payload: dict) -> dict:
    global _latency_ms
    if not _connected or _sock is None:
        return {}
    line = json.dumps(payload) + "\n"
    t0   = time.time()
    try:
        with _send_lock:
            _sock.sendall(line.encode())
        _latency_ms = (time.time() - t0) * 1000
    except Exception as e:
        pass
    return {}


# ── Curses UI ─────────────────────────────────────────────────────────────────
LEG_NAMES = {1:"Front-R", 2:"Right", 3:"Back-R",
             4:"Back-L",  5:"Left",  6:"Front-L"}

def _draw(stdscr, h, w):
    with _telem_lock:
        t = dict(_telemetry)

    stdscr.clear()
    row = 0

    def put(r, c, text, attr=0):
        try:
            stdscr.addstr(r, c, text, attr)
        except curses.error:
            pass

    # Title bar
    title = " PROJECT ARACHNID — CONTROLLER "
    put(row, (w - len(title)) // 2, title,
        curses.color_pair(1) | curses.A_BOLD)
    row += 1
    put(row, 0, "─" * w, curses.color_pair(3))
    row += 1

    # Connection
    conn_str = f" ◉ CONNECTED  {RPI_IP}:{RPI_PORT}  ping:{_latency_ms:.1f}ms" \
               if _connected else f" ✗ DISCONNECTED — retrying {RPI_IP}:{RPI_PORT}"
    conn_col = curses.color_pair(2) if _connected else curses.color_pair(4)
    put(row, 0, conn_str, conn_col | curses.A_BOLD)
    row += 2

    # Mode bar
    mode_str = f" MODE {_mode}: {'FULL BODY' if _mode==1 else f'SINGLE LEG — Leg {_selected_leg} ({LEG_NAMES.get(_selected_leg,\"?\")})'}"
    mode_col = curses.color_pair(2) if _mode == 1 else curses.color_pair(5)
    put(row, 0, mode_str, mode_col | curses.A_BOLD)
    put(row, 40, f" Step size: {_step_size:.1f}x ")
    row += 1
    put(row, 0, f" Last cmd: {_last_cmd}")
    row += 2

    # ── Sensor columns ────────────────────────────────────────────────────────
    put(row, 0,  "[ GAS SENSORS ]", curses.A_BOLD)
    put(row, 35, "[ ENVIRONMENT ]", curses.A_BOLD)
    put(row, 60, "[ IMU ]", curses.A_BOLD)
    row += 1

    gas   = t.get("gas",        {})
    dht   = t.get("dht",        {})
    imu   = t.get("imu",        {})
    ultra = t.get("ultrasonic", {})
    gps   = t.get("gps",        {})

    gas_sensors = [("MQ2","Smoke/LPG"),("MQ4","Methane"),("MQ5","LPG/Coal"),
                   ("MQ6","LPG/Propane"),("MQ7","CO"),("MQ8","H2")]
    for i, (key, label) in enumerate(gas_sensors):
        val   = gas.get(key, 0)
        alert = val > 400
        color = curses.color_pair(4) if alert else curses.color_pair(2)
        bar   = "█" * min(int(val / 40), 20)
        put(row + i, 0, f"  {key:<4} {label:<11}: {val:4d} ", color)
        put(row + i, 24, bar, color)
    row += 7

    # Environment
    put(row, 35, f"  Temp  : {dht.get('temp_c',0):.1f} °C")
    put(row, 60, f"  Roll  : {imu.get('roll_deg',0):+6.1f}°")
    row += 1
    put(row, 35, f"  Humid : {dht.get('humidity_pct',0):.1f} %")
    put(row, 60, f"  Pitch : {imu.get('pitch_deg',0):+6.1f}°")
    row += 1
    put(row, 35, f"  Front : {ultra.get('front_cm',999):4d} cm")
    put(row, 60, f"  Ax    : {imu.get('accel_x',0):+5.2f}")
    row += 1
    put(row, 35, f"  Left  : {ultra.get('left_cm',999):4d} cm")
    put(row, 60, f"  Ay    : {imu.get('accel_y',0):+5.2f}")
    row += 1
    put(row, 35, f"  Right : {ultra.get('right_cm',999):4d} cm")
    put(row, 60, f"  Az    : {imu.get('accel_z',0):+5.2f}")
    row += 2

    # GPS
    fix_str = "FIX" if gps.get("fix") else "NO FIX"
    fix_col = curses.color_pair(2) if gps.get("fix") else curses.color_pair(4)
    put(row, 0, f"  GPS: {fix_str}  ", fix_col)
    put(row, 16, f"Lat: {gps.get('lat',0):.6f}  Lon: {gps.get('lon',0):.6f}  Sats: {gps.get('sats',0)}")
    row += 2

    # Alerts
    alerts = t.get("alerts", [])
    if alerts:
        put(row, 0, " ⚠ ALERTS:", curses.color_pair(4) | curses.A_BOLD)
        row += 1
        for a in alerts:
            put(row, 2, f"  • {a}", curses.color_pair(4))
            row += 1
        row += 1

    # Key legend
    put(row, 0, "─" * w, curses.color_pair(3))
    row += 1
    if _mode == 1:
        put(row, 0, " W/S=Fwd/Back  A/D=Strafe  Q/E=Turn  SPACE=Stand  TAB=LegMode  ESC=ESTOP  R=Resume  +/-=Speed")
    else:
        put(row, 0, " W/S=Fwd/Back  A/D=Left/Right  Z/X=Up/Down  1-6=Select Leg  TAB=BodyMode  ESC=ESTOP")

    stdscr.refresh()


def _run(stdscr):
    global _mode, _selected_leg, _step_size, _last_cmd

    curses.curs_set(0)
    stdscr.nodelay(True)
    curses.start_color()
    curses.init_pair(1, curses.COLOR_CYAN,    curses.COLOR_BLACK)
    curses.init_pair(2, curses.COLOR_GREEN,   curses.COLOR_BLACK)
    curses.init_pair(3, curses.COLOR_BLUE,    curses.COLOR_BLACK)
    curses.init_pair(4, curses.COLOR_RED,     curses.COLOR_BLACK)
    curses.init_pair(5, curses.COLOR_YELLOW,  curses.COLOR_BLACK)

    _connect()
    t = threading.Thread(target=_recv_thread, daemon=True)
    t.start()

    s  = STEP_M
    sr = STEP_RAD
    ls = LEG_STEP_M
    lz = LEG_STEP_Z

    while True:
        h, w = stdscr.getmaxyx()
        _draw(stdscr, h, w)

        key = stdscr.getch()
        if key == -1:
            time.sleep(0.05)
            continue

        ch = chr(key) if 32 <= key <= 126 else ""

        # ── Universal keys ─────────────────────────────────────────────────
        if key == 27:   # ESC
            send_cmd({"cmd": "ESTOP"})
            _last_cmd = "ESTOP"
        elif ch == "r" or ch == "R":
            send_cmd({"cmd": "RESUME"})
            _last_cmd = "RESUME"
        elif ch == "+":
            _step_size = min(_step_size + 0.1, 3.0)
        elif ch == "-":
            _step_size = max(_step_size - 0.1, 0.2)
        elif ch == "p" or ch == "P":
            send_cmd({"cmd": "PING"})
            _last_cmd = "PING"
        elif key == 9:  # TAB
            _mode = 2 if _mode == 1 else 1
            send_cmd({"cmd": "SETMODE", "mode": _mode})
            _last_cmd = f"MODE → {_mode}"

        # ── Mode 1: full body ──────────────────────────────────────────────
        elif _mode == 1:
            dx, dy, dyaw = 0.0, 0.0, 0.0
            if   ch in ("w","W"): dx =  s * _step_size
            elif ch in ("s","S"): dx = -s * _step_size
            elif ch in ("d","D"): dy = -s * _step_size
            elif ch in ("a","A"): dy =  s * _step_size
            elif ch in ("q","Q"): dyaw =  sr * _step_size
            elif ch in ("e","E"): dyaw = -sr * _step_size
            elif ch == " ":
                send_cmd({"cmd": "STAND"})
                _last_cmd = "STAND"
                continue
            elif ch in ("n","N"):
                send_cmd({"cmd": "NEUTRAL"})
                _last_cmd = "NEUTRAL"
                continue
            else:
                continue

            if dx or dy or dyaw:
                send_cmd({"cmd": "WALK", "dx": dx, "dy": dy, "dyaw": dyaw})
                dir_label = ""
                if dx > 0:  dir_label = "FORWARD"
                elif dx < 0: dir_label = "BACKWARD"
                elif dy > 0: dir_label = "STRAFE LEFT"
                elif dy < 0: dir_label = "STRAFE RIGHT"
                elif dyaw > 0: dir_label = "TURN LEFT"
                elif dyaw < 0: dir_label = "TURN RIGHT"
                _last_cmd = f"WALK {dir_label} (step={_step_size:.1f}x)"

        # ── Mode 2: single leg ─────────────────────────────────────────────
        elif _mode == 2:
            if ch in "123456":
                _selected_leg = int(ch)
                send_cmd({"cmd": "SELECTLEG", "leg": _selected_leg})
                _last_cmd = f"SELECT LEG {_selected_leg}"
                continue

            ldx, ldy, ldz = 0.0, 0.0, 0.0
            if   ch in ("w","W"): ldx =  ls * _step_size
            elif ch in ("s","S"): ldx = -ls * _step_size
            elif ch in ("d","D"): ldy = -ls * _step_size
            elif ch in ("a","A"): ldy =  ls * _step_size
            elif ch in ("z","Z"): ldz = -lz * _step_size  # up = z decreases
            elif ch in ("x","X"): ldz =  lz * _step_size  # down
            else:
                continue

            if ldx or ldy or ldz:
                send_cmd({"cmd": "LEG", "leg": _selected_leg,
                          "dx": ldx, "dy": ldy, "dz": ldz})
                _last_cmd = f"LEG {_selected_leg} move ({ldx:.3f},{ldy:.3f},{ldz:.3f})"


def main():
    print(f"Connecting to Arachnid at {RPI_IP}:{RPI_PORT} ...")
    curses.wrapper(_run)


if __name__ == "__main__":
    main()
