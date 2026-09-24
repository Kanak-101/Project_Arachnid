# 🕷️ Complete Raspberry Pi Getting Started Guide — Nav2 & SLAM

This guide walks you through every single step to get RPLidar, Cartographer, and Nav2 autonomously driving your quadbot on your Raspberry Pi.

---

## 📋 Architecture & Data Flow

```text
[RPLidar USB] 
      │
      ▼
[/scan topic] ───► [Cartographer Node] ──► publishes [map → odom TF] & [/map]
      │                     ▲
      ▼                     │
[Nav2 Costmaps] ────────────┘
      │
      ▼ (Global/Local Planners)
[/cmd_vel] ──► [cmd_vel_bridge node] ──(WebSocket ws://127.0.0.1:8000/ws)──► [quadbot.server] ──► [PCA9685 Servos]
```

---

## ⚡ Step 1: Connect to Pi & Pull Changes

Open PowerShell or terminal on your laptop:

```bash
# 1. SSH into the Pi
ssh <your_pi_username>@<your_pi_ip>

# 2. Go to your repo folder
cd ~/Project_Arachnid
# (or wherever your repo directory is located on your Pi)

# 3. Discard or stash any local conflict files if needed
git stash

# 4. Pull latest commit from main
git pull origin main
```

---

## 📦 Step 2: Install System & ROS 2 Dependencies

Nav2 and Cartographer need native binaries. Run this once on the Pi:

```bash
sudo apt update
sudo apt install -y \
  ros-${ROS_DISTRO}-navigation2 \
  ros-${ROS_DISTRO}-nav2-bringup \
  ros-${ROS_DISTRO}-cartographer \
  ros-${ROS_DISTRO}-cartographer-ros \
  ros-${ROS_DISTRO}-tf2-ros \
  ros-${ROS_DISTRO}-rplidar-ros \
  python3-websockets
```

> [!NOTE]
> If your environment does not have `$ROS_DISTRO` set, check which ROS 2 version you have (usually `humble` or `jazzy`). Replace `${ROS_DISTRO}` with `humble` or `jazzy`.

---

## 🔌 Step 3: Check Hardware & USB Permissions

### 1. Give RPLidar USB permissions
When plugging in RPLidar to Pi USB port:
```bash
ls -l /dev/ttyUSB*
```
You should see `/dev/ttyUSB0`. Give it read/write permissions:
```bash
sudo chmod 666 /dev/ttyUSB0
```
*(To make this permanent across reboots, add your user to dialout: `sudo usermod -a -G dialout $USER` and log back in).*

### 2. Verify I2C is working (PCA9685 & MPU6050)
```bash
sudo i2cdetect -y 1
```
You should see your PCA9685 addresses (`0x40`, `0x50`) and optionally MPU6050 (`0x68`).

---

## 🛠️ Step 4: Build the ROS 2 Workspace

From the root of your workspace on the Pi:

```bash
cd ~/Project_Arachnid

# Clean previous build artifacts if needed
rm -rf build/quadbot_nav2 install/quadbot_nav2

# Build all 3 core packages
colcon build --packages-select quadbot_cartographer cmd_vel_bridge quadbot_nav2 --symlink-install

# Source the overlay
source install/setup.bash
```

Ensure it finishes without errors. Add sourcing to your `~/.bashrc` so every new terminal has it:
```bash
echo "source ~/Project_Arachnid/install/setup.bash" >> ~/.bashrc
```

---

## 🚀 Step 5: Running the System (Multi-Terminal Workflow)

To avoid everything crashing together, run each core component in its own terminal (or use `tmux`).

### Terminal 1: Start Quadbot Hardware Server
This drives the PCA9685 servos and listens on WebSocket port 8000:
```bash
cd ~/Project_Arachnid
source install/setup.bash
python3 -m quadbot.server --config quadbot/config/robot.yaml --host 0.0.0.0
```
- Open `http://<pi_ip>:8000` in your laptop browser to see the dashboard.
- **Arm the robot and put it in `stand` or `crawl` mode** so it responds to drive commands.

---

### Terminal 2: Launch RPLidar Node (if not already running inside server)
If you are streaming scan into ROS 2 directly via `rplidar_ros`:
```bash
source /opt/ros/${ROS_DISTRO}/setup.bash
ros2 run rplidar_ros rplidar_node --ros-args \
  -p serial_port:=/dev/ttyUSB0 \
  -p serial_baudrate:=115200 \
  -p frame_id:=laser \
  -p angle_compensate:=true
```

Test that the scan is publishing:
```bash
ros2 topic hz /scan
# Should output: average rate: ~5.5Hz - 10Hz
```

---

### Terminal 3: Launch Nav2 + Cartographer SLAM + Bridge
This starts:
1. Static TF (`base_link -> laser`)
2. `cartographer_node` + `occupancy_grid_node` (publishes `/map` and `map -> odom`)
3. `cmd_vel_bridge` (listens on `/cmd_vel` -> sends WebSocket drive packet to `quadbot.server`)
4. Full Nav2 stack (planner, controller, BT navigator, costmaps)

```bash
cd ~/Project_Arachnid
source install/setup.bash
ros2 launch quadbot_nav2 quadbot_nav2_slam.launch.py
```

Check lifecycle status:
```bash
ros2 lifecycle list /controller_server
# Should show [active]
```

---

## 💻 Step 6: Visualizing & Driving with RViz2 (From your Laptop)

Do **NOT** run RViz2 on the Pi directly (it will overheat or lag the Pi CPU/GPU). Run RViz2 on your laptop.

### 1. Ensure both Laptop and Pi are on the same Wi-Fi
Set the same `ROS_DOMAIN_ID` on both Pi and Laptop:
```bash
# In Pi ~/.bashrc and Laptop terminal:
export ROS_DOMAIN_ID=0
```

### 2. On your Laptop:
```bash
cd ~/Project_Arachnid
source install/setup.bash
ros2 launch quadbot_nav2 rviz.launch.py
```

### 3. Send Goals:
1. In RViz2, you will see the red laser points and the gray occupancy grid building as the robot moves.
2. Click **"2D Nav Goal"** (or **"Nav2 Goal"**) on the RViz top toolbar.
3. Click and drag anywhere on the map to set a goal position and heading direction.
4. Watch Nav2 generate a green path, plan speed commands on `/cmd_vel`, which bridge to your quadbot server!

---

## 💾 Step 7: Saving Your Map for Future Pure Navigation

Once you've explored the room and built a complete map:

On the Pi (or laptop):
```bash
ros2 run nav2_map_server map_saver_cli -f ~/Project_Arachnid/src/quadbot_nav2/maps/my_room
```
This generates:
- `my_room.yaml`
- `my_room.pgm`

### Navigating on the Saved Map Later (without running SLAM):
```bash
ros2 launch quadbot_nav2 quadbot_nav2_localization.launch.py map:=$HOME/Project_Arachnid/src/quadbot_nav2/maps/my_room.yaml
```
In RViz, use **"2D Pose Estimate"** first to tell AMCL where the robot started, then click **"2D Nav Goal"**.

---

## 🔧 Troubleshooting Quick-Fixes

| Issue | Cause | Fix |
|---|---|---|
| `cmd_vel_bridge: Quadbot websocket unavailable` | `quadbot.server` isn't running or wrong port | Start `python3 -m quadbot.server` first in Terminal 1. |
| `Waiting for transform map -> odom` | Cartographer hasn't received scan or crashed | Verify `ros2 topic echo /scan --once`. Ensure frame is `laser`. |
| Robot doesn't move when goal is given | Robot not armed in dashboard | Go to `http://<pi_ip>:8000`, click **Arm**, and set mode to **crawl** or **trot**. |
| DWB planner error: Extrapolation into future | Time sync between laptop & Pi | Install `chrony` or sync clocks with `sudo date -s "..."`. |
