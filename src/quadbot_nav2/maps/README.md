# Saved Maps Directory

Place your Cartographer-generated maps here.

## How to save a map

While the SLAM launch is running:

```bash
# Save the current map
ros2 run nav2_map_server map_saver_cli -f ~/quadbot_ws/src/quadbot_nav2/maps/my_map

# This creates:
#   my_map.pgm   (occupancy grid image)
#   my_map.yaml  (metadata: resolution, origin, thresholds)
```

## How to use a saved map

```bash
ros2 launch quadbot_nav2 quadbot_nav2_localization.launch.py \
    map:=$(ros2 pkg prefix quadbot_nav2)/share/quadbot_nav2/maps/my_map.yaml
```
