# quadbot: bench console, servo calibration, drive, lidar

Milestone 1 of the quadruped build. Runs on the Raspberry Pi 5; you open the dashboard from a
laptop or phone on the same network. Everything works in **mock mode** on any computer, so you can
develop and rehearse without the robot.

## What is in this drop

| Piece | Where | State |
|---|---|---|
| Servo calibration dashboard (per-servo jog, centre/low/high, invert, scale, sweep, save) | `web/`, `quadbot/robot.py` | tested in mock mode |
| Safety: arm, per-servo enable, e-stop latch, command watchdog, ramped jogs, speed/range limiting | `quadbot/robot.py`, `servos.py` | tested in mock mode |
| Leg kinematics + foot-position test tab | `kinematics.py` | tested (round-trip) |
| Crawl / trot / stand / rest gaits + turning | `gait.py` | tested in simulation |
| Auto-slow: gait slows when a servo can't keep up | `servos.py` | tested in simulation |
| Joystick (gamepad, touch sticks, keyboard) | `web/app.js` | tested with keyboard; gamepad code untested |
| Lidar radar view, obstacle stop / slow / steer-around | `lidar.py`, `avoid.py` | avoidance tested; RPLidar driver **untested on hardware** |
| PCA9685 servo driver | `hal.py` | register writes tested against a fake bus; **untested on hardware** |

Not in this drop (next): click-to-go, person tracking, CPG.

## Run it on a laptop (mock)

    python3 -m venv .venv && source .venv/bin/activate
    pip install -r requirements.txt
    python -m quadbot.server              # then open http://localhost:8000
    pytest                                # 52 tests

## Bring-up on the Pi 5

1. `sudo raspi-config` -> Interface Options -> I2C -> enable. Reboot. `sudo apt install i2c-tools`.
   - **Dual PCA9685 boards:** On the Right PCA9685 board, set address to `0x50` (bridge the **A4** address solder pads: 0x40 + 0x10 = 0x50). Leave the Left PCA9685 board unmodified (default address `0x40`).
   - Wire both boards in parallel to the Pi 5's I2C pins: SDA (pin 3), SCL (pin 5), 3.3V logic (pin 1), and GND (pin 6/9).
2. `pip install -r requirements-pi.txt` (inside a venv).
   - Add your user to the `i2c` and `dialout` groups so you can access the I2C bus and lidar without sudo:
     ```bash
     sudo usermod -aG i2c,dialout $USER
     ```
   - Log out and log back in (or run `newgrp i2c`) so the new group permissions apply.
3. **Power & Preventing Servo Jitter:**
   - **Common Ground:** Tie the external servo power supply ground (`GND`) to the Raspberry Pi `GND` (Pin 6). A floating ground reference causes violent servo jitter/twitching.
   - **Current Capacity:** 12 MG958 / MG996R / MG995 servos draw 10A–15A peak. If voltage drops below ~4.5V, servo microcontrollers reset continuously (chatter/buzzing). Use a dedicated 8A–15A 5V–6V battery/BEC.
   - **Logic VCC:** Connect PCA9685 `VCC` to Pi 3.3V (Pin 1). Connect servo power (5V–6V) only to the `V+` screw terminals.
4. **Hardware Diagnostic CLI Tool:**
   Before launching the web server, run the built-in diagnostic tool to test each board, channel, and gait:
   ```bash
   python -m quadbot.diag
   ```
   Or run specific checks:
   - `python -m quadbot.diag --scan` (Scans I2C bus for 0x40 and 0x50)
   - `python -m quadbot.diag --test-servo FL_coxa` (Jogs ONE servo to check channel wiring)
   - `python -m quadbot.diag --all-1500` (Smoothly centers all 12 servos sequentially)
   - `python -m quadbot.diag --stand` (Tests Stand pose kinematics)
   - `python -m quadbot.diag --crawl` (Tests 5-second crawling walk test directly in terminal)
   - `python -m quadbot.diag --turn` (Tests 5-second in-place turning test)
   - `python -m quadbot.diag --release` (Immediately releases all channels)
5. `python -m quadbot.server --host 0.0.0.0`, then open `http://<pi-address>:8000`.
   To start on boot use `deploy/quadbot.service`.

There is no login. Anyone on the network can drive the robot. Use your own router or hotspot.

## First-power checklist (do this in order)

1. Robot propped so every leg hangs free. Servo supply off. Start the dashboard.
2. Servo supply on. Press **Arm servos**, then go to **Calibrate**. Nothing moves yet: a servo is only driven once you press its Enable.
3. One servo at a time: **Enable**, then jog with the ±1 / ±10 buttons. The slider ramps at a limited speed, so a drag cannot slam the horn into a stop.
4. **Set centre** at the calibration pose: coxa straight out from the body, femur level, tibia vertical.
5. Jog toward each end. **Set low** and **Set high** a little before the mechanical stop.
6. Watch the **Pose map**. If the drawn leg moves the opposite way to the real one, press **Invert**. Expect several right-side servos to need it.
7. **Calibrate scale**: jog to an angle you can measure, enter it, press the button. The default assumes about 180 degrees across the pulse range, which is only a guess.
8. **Sweep test** shows the servo's whole calibrated range slowly. Listen for buzzing or stalling at the ends and tighten the limits if you hear it.
9. **Save config**. The old file is kept as `robot.yaml.bak`.
10. **Legs** tab: measure your leg segments, put the real coxa / femur / tibia lengths and hip positions into `robot.yaml`, then use the foot-position test to check each leg before any walking.
11. Only then: **Drive**, **Stand**, then **Crawl** with the body held off the ground.

## How the pieces fit

    dashboard (browser)  --websocket-->  server.py  -->  robot.py (50 Hz control tick)
                                                            |-- gait.py         drive command -> foot targets
                                                            |-- kinematics.py   foot targets -> joint angles
                                                            |-- servos.py       limits, speed cap, auto-slow, angle -> pulse
                                                            `-- hal.py          pulse -> PCA9685 (or mock)
    lidar.py --scan--> avoid.py --adjusted drive command--> gait.py

- **Angles** are measured from the calibration pose. Coxa + swings the leg forward, femur + lifts it, tibia + opens the knee. The **Invert** flag maps that to the physical servo direction.
- **Auto-slow:** if a joint can't keep up with its rated speed (or hits its range), the gait rate drops until it can. The **What is holding the gait back** panel shows which joint is responsible.
- **Watchdog:** the dashboard sends the drive command every 50 ms. If none arrive for 0.4 s the robot stops. A stale lidar scan stops forward motion while avoidance is on.
- The CPG plugs in later at `gait.py`, by supplying phase and per-leg offsets in place of the fixed ones.

## Known limits, stated plainly

- **Unverified numbers:** leg lengths, hip positions, servo scale, max speeds, and channel order are placeholders (see comments in `robot.yaml`). Channels are assumed to be 0 to 11 in the order of your calibration sheet.
- **The first pulse after enabling a servo can snap it** to that position at full servo speed, because a servo's real position is unknown until it is driven. Enable one servo at a time, with the legs free.
- The crawl and trot are open-loop kinematic gaits with no balance control. Expect to tune step height, body height, and step rate on the real robot.
- The lidar assumes it sits level. When the body tilts, scans hit the floor. Keep the floor flat until tilt gating is added.
- The layout was checked in a headless DOM test, not on a real screen or phone.
