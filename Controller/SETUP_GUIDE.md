# Project Arachnid — Complete Setup & Deployment Guide

---

## 1. File Overview

```
arachnid/
├── rpi/
│   ├── servo_driver.py        ← PCA9685 low-level servo interface
│   ├── gait_engine.py         ← Tripod gait + IK + single-leg control
│   ├── sensor_node.py         ← All sensors in parallel threads
│   ├── arachnid_server.py     ← TCP server (MAIN ENTRY POINT on RPi)
│   ├── arachnid_sensors.ino   ← Arduino sketch (upload to Uno)
│   ├── setup_static_ip.sh     ← One-time network config script
│   └── arachnid.service       ← systemd auto-start service
└── laptop/
    └── arachnid_controller.py ← Keyboard controller (run on your laptop/WSL)
```

---

## 2. Hardware Wiring

### PCA9685 Boards (I2C)
Connect both boards to RPi I2C pins:
```
RPi Pin 3  (GPIO2, SDA)  → SDA on BOTH boards
RPi Pin 5  (GPIO3, SCL)  → SCL on BOTH boards
RPi Pin 6  (GND)         → GND on both boards
RPi Pin 2  (5V)          → VCC on both boards (logic only)
External 5V/6V supply    → V+ on both boards (servo power — DO NOT use RPi 5V)
```

Board address jumpers:
- Board A (Legs 1–3): A0=LOW, A1=LOW → address 0x40 (default, no solder)
- Board B (Legs 4–6): A0=HIGH, A1=LOW → address 0x41 (bridge A0 solder jumper)

Servo channel assignment per board:
```
Board A (0x40):        Board B (0x41):
  Ch 0 → Leg 1 J1 (Coxa)    Ch 0 → Leg 4 J1
  Ch 1 → Leg 1 J2 (Femur)   Ch 1 → Leg 4 J2
  Ch 2 → Leg 1 J3 (Tibia)   Ch 2 → Leg 4 J3
  Ch 3 → Leg 2 J1            Ch 3 → Leg 5 J1
  Ch 4 → Leg 2 J2            Ch 4 → Leg 5 J2
  Ch 5 → Leg 2 J3            Ch 5 → Leg 5 J3
  Ch 6 → Leg 3 J1            Ch 6 → Leg 6 J1
  Ch 7 → Leg 3 J2            Ch 7 → Leg 6 J2
  Ch 8 → Leg 3 J3            Ch 8 → Leg 6 J3
```

Leg numbering (top view, X = forward):
```
    L6 ──── L1
    L5        L2
    L4 ──── L3
```

### Arduino Uno (Sensors)
```
MQ-2  → A0       MQ-4  → A1       MQ-5  → A2
MQ-6  → A3       MQ-7  → A4       MQ-8  → A5
HC-SR04 FRONT:  TRIG=D2, ECHO=D3
HC-SR04 LEFT:   TRIG=D4, ECHO=D5
HC-SR04 RIGHT:  TRIG=D6, ECHO=D7
Arduino USB     → RPi USB port (appears as /dev/ttyUSB0)
```

### DHT11
```
DHT11 DATA → RPi GPIO 4 (Pin 7)
DHT11 VCC  → RPi 3.3V
DHT11 GND  → RPi GND
```

### MPU6050 IMU
```
MPU6050 SDA → RPi GPIO 2 (shares I2C bus with PCA9685)
MPU6050 SCL → RPi GPIO 3
MPU6050 VCC → RPi 3.3V
MPU6050 GND → RPi GND
MPU6050 AD0 → GND  (sets I2C address to 0x68)
```

### GPS M8N
```
GPS TX → RPi GPIO 15 (Pin 10, UART RX = /dev/ttyAMA0)
GPS RX → RPi GPIO 14 (Pin 8,  UART TX — optional)
GPS VCC → 3.3V or 5V (check your module)
GPS GND → GND
```
Enable UART on RPi: `sudo raspi-config` → Interface Options → Serial Port
  → "login shell over serial?" → NO
  → "serial port hardware enabled?" → YES

---

## 3. RPi Software Setup

SSH into the RPi (use default: `ssh pi@raspberrypi.local` before static IP).

### Install Python dependencies
```bash
sudo apt update && sudo apt install -y python3-pip libgpiod2 i2c-tools
pip3 install adafruit-circuitpython-pca9685 \
             adafruit-circuitpython-servokit \
             adafruit-circuitpython-dht \
             adafruit-circuitpython-mpu6050 \
             pyserial pynmea2
```

### Enable I2C
```bash
sudo raspi-config
# Interface Options → I2C → Enable
```

Verify boards are detected:
```bash
sudo i2cdetect -y 1
# Should show 0x40 and 0x41 for PCA9685 boards, 0x68 for MPU6050
```

### Upload Arduino sketch
1. Open `arachnid_sensors.ino` in Arduino IDE on your laptop
2. Select Board: Arduino Uno, Port: (your COM port)
3. Upload
4. Transfer the .ino to RPi is NOT needed — it runs on the Uno directly

### Copy project files to RPi
```bash
# From your laptop (WSL or terminal):
scp rpi/*.py pi@192.168.0.100:/home/pi/arachnid/
```

---

## 4. Static IP Setup

### On the RPi
```bash
chmod +x /home/pi/arachnid/setup_static_ip.sh
bash /home/pi/arachnid/setup_static_ip.sh
```
RPi Ethernet is now: **192.168.0.100**

### On your Windows laptop
1. Control Panel → Network and Internet → Network Connections
2. Right-click Ethernet adapter → Properties
3. Select "Internet Protocol Version 4 (TCP/IPv4)" → Properties
4. Set:
   - IP address:    `192.168.0.101`
   - Subnet mask:   `255.255.255.0`
   - Default gateway: (leave blank)
5. OK → Close

### Test the connection
```bash
# From WSL:
ping 192.168.0.100

# From RPi:
ping 192.168.0.101
```

---

## 5. Running the System

### Start the server on RPi
```bash
ssh pi@192.168.0.100
cd /home/pi/arachnid
python3 arachnid_server.py
```
You should see:
```
  Project Arachnid — RPi Server
[boot] Initialising servos...
[servo_driver] PCA9685 boards initialised.
[boot] Starting sensor threads...
[sensor] Started thread: arduino
[sensor] Started thread: dht
...
[server] Listening on 0.0.0.0:5000
```

### Run the controller on your laptop (WSL)
```bash
cd laptop/
pip install windows-curses   # first time only
python3 arachnid_controller.py
```

---

## 6. Auto-start on Boot (optional but recommended)

```bash
# On RPi:
sudo cp /home/pi/arachnid/arachnid.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable arachnid
sudo systemctl start arachnid

# Check status:
sudo systemctl status arachnid
journalctl -u arachnid -f   # live logs
```

---

## 7. Controller Key Bindings

### Mode 1 — Full Body
| Key | Action |
|-----|--------|
| W | Forward |
| S | Backward |
| A | Strafe Left |
| D | Strafe Right |
| Q | Turn Left (CCW) |
| E | Turn Right (CW) |
| SPACE | Stand (home pose) |
| N | Neutral (all joints centre) |
| TAB | Switch to Mode 2 |
| ESC | **Emergency Stop** (servos go limp) |
| R | Resume from E-Stop |
| + / - | Increase / Decrease step size |

### Mode 2 — Single Leg
| Key | Action |
|-----|--------|
| 1–6 | Select leg (1=Front-R, 2=Right, 3=Back-R, 4=Back-L, 5=Left, 6=Front-L) |
| W / S | Move foot Forward / Backward |
| A / D | Move foot Left / Right |
| Z / X | Move foot Up / Down |
| TAB | Back to Mode 1 |

---

## 8. Tuning the Gait

Edit these values in `gait_engine.py` after your first test:

```python
STEP_LENGTH   = 0.035   # reduce if legs slip or collide
STEP_HEIGHT   = 0.030   # increase if feet drag on ground
BODY_HEIGHT   = 0.080   # adjust to match actual standing height
CYCLE_TIME    = 0.5     # increase (slower) if servos can't keep up
```

---

## 9. Troubleshooting

| Problem | Fix |
|---------|-----|
| `OSError: [Errno 121] Remote I/O error` | I2C not enabled, or board address wrong |
| Servos twitch but don't move | Swap PULSE_MIN/MAX values in servo_driver.py |
| Legs move wrong direction | Negate the affected joint angle in set_joint_rad |
| Arduino not found | Check `ls /dev/ttyUSB*`, update port in sensor_node.py |
| GPS no data | Run `sudo raspi-config` and enable serial hardware |
| Controller can't connect | Check IP in arachnid_controller.py matches RPi |
| Servos go limp immediately | Power supply voltage too low — use 5V/6V 5A+ |

---

## 10. Sensor Port Reference

Edit `arachnid_server.py` → `sensor_node.start_all(...)` if your ports differ:

```python
sensor_node.start_all(
    arduino_port = "/dev/ttyUSB0",   # Arduino Uno
    gps_port     = "/dev/ttyAMA0",   # GPS M8N via UART
    dht_pin      = 4,                # DHT11 GPIO pin number
)
```
