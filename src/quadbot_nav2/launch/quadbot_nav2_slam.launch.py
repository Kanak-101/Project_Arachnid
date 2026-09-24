"""
Launch Nav2 with Cartographer SLAM for the quadbot.

Use this when you DON'T have a pre-built map yet.
Cartographer does the SLAM (provides map→odom TF and /map),
Nav2 handles path planning, obstacle avoidance, and goal navigation.

Usage (on the Pi / Jetson):
    ros2 launch quadbot_nav2 quadbot_nav2_slam.launch.py

Then in RViz2 set a 2D Nav Goal to drive the robot autonomously while
simultaneously building the map.  When you're happy with the map, save it:
    ros2 run nav2_map_server map_saver_cli -f ~/maps/my_map
"""

from launch import LaunchDescription
from launch.actions import DeclareLaunchArgument, IncludeLaunchDescription, GroupAction
from launch.launch_description_sources import PythonLaunchDescriptionSource
from launch.substitutions import LaunchConfiguration, PathJoinSubstitution
from launch_ros.actions import Node, SetRemap
from ament_index_python.packages import get_package_share_directory
import os


def generate_launch_description():

    # ---------- paths ----------
    nav2_pkg = get_package_share_directory('quadbot_nav2')
    carto_pkg = get_package_share_directory('quadbot_cartographer')
    nav2_bringup_pkg = get_package_share_directory('nav2_bringup')

    nav2_params_file = os.path.join(nav2_pkg, 'config', 'nav2_params.yaml')
    carto_config_dir = os.path.join(carto_pkg, 'config')

    # ---------- arguments ----------
    use_sim_time = LaunchConfiguration('use_sim_time')

    return LaunchDescription([

        DeclareLaunchArgument('use_sim_time', default_value='false',
                              description='Use simulation clock'),

        # ======== 1. Static TF: base_link → laser ========
        # Adjust x/y/z if the lidar is not centred on base_link
        Node(
            package='tf2_ros',
            executable='static_transform_publisher',
            name='base_to_laser_tf',
            arguments=['0', '0', '0', '0', '0', '0', 'base_link', 'laser'],
        ),

        # ======== 2. Cartographer SLAM ========
        Node(
            package='cartographer_ros',
            executable='cartographer_node',
            name='cartographer_node',
            output='screen',
            parameters=[{'use_sim_time': use_sim_time}],
            arguments=[
                '-configuration_directory', carto_config_dir,
                '-configuration_basename', 'quadbot.lua',
            ],
            remappings=[('scan', '/scan')],
        ),

        # Cartographer occupancy grid (publishes /map for Nav2)
        Node(
            package='cartographer_ros',
            executable='cartographer_occupancy_grid_node',
            name='cartographer_occupancy_grid_node',
            output='screen',
            parameters=[{'use_sim_time': use_sim_time}],
            arguments=['-resolution', '0.05', '-publish_period_sec', '1.0'],
        ),

        # ======== 3. RPLidar driver ========
        # If rplidar_ros is installed and you're using a hardware lidar,
        # uncomment the block below. Otherwise the lidar node should be
        # launched separately.
        # Node(
        #     package='rplidar_ros',
        #     executable='rplidar_node',
        #     name='rplidar_node',
        #     output='screen',
        #     parameters=[{
        #         'serial_port': '/dev/ttyUSB0',
        #         'serial_baudrate': 115200,
        #         'frame_id': 'laser',
        #         'angle_compensate': True,
        #         'scan_mode': 'Standard',
        #     }],
        # ),

        # ======== 4. cmd_vel_bridge ========
        # Forwards /cmd_vel from Nav2 → quadbot websocket server
        Node(
            package='cmd_vel_bridge',
            executable='bridge_node',
            name='cmd_vel_bridge',
            output='screen',
            parameters=[{
                'websocket_url': 'ws://127.0.0.1:8000/ws',
                'max_linear_mps': 0.05,
                'max_angular_rps': 0.6,
                'command_timeout_s': 0.4,
                'publish_rate_hz': 20.0,
            }],
        ),

        # ======== 5. Nav2 stack (without AMCL / map_server — SLAM provides those) ========
        # We launch the Nav2 nodes directly instead of using nav2_bringup to
        # avoid launching AMCL (which conflicts with Cartographer's localization).

        Node(
            package='nav2_controller',
            executable='controller_server',
            name='controller_server',
            output='screen',
            parameters=[nav2_params_file, {'use_sim_time': use_sim_time}],
        ),

        Node(
            package='nav2_planner',
            executable='planner_server',
            name='planner_server',
            output='screen',
            parameters=[nav2_params_file, {'use_sim_time': use_sim_time}],
        ),

        Node(
            package='nav2_behaviors',
            executable='behavior_server',
            name='behavior_server',
            output='screen',
            parameters=[nav2_params_file, {'use_sim_time': use_sim_time}],
        ),

        Node(
            package='nav2_bt_navigator',
            executable='bt_navigator',
            name='bt_navigator',
            output='screen',
            parameters=[nav2_params_file, {'use_sim_time': use_sim_time}],
        ),

        Node(
            package='nav2_waypoint_follower',
            executable='waypoint_follower',
            name='waypoint_follower',
            output='screen',
            parameters=[nav2_params_file, {'use_sim_time': use_sim_time}],
        ),

        # Lifecycle manager brings up all Nav2 nodes
        Node(
            package='nav2_lifecycle_manager',
            executable='lifecycle_manager',
            name='lifecycle_manager_navigation',
            output='screen',
            parameters=[{
                'use_sim_time': use_sim_time,
                'autostart': True,
                'node_names': [
                    'controller_server',
                    'planner_server',
                    'behavior_server',
                    'bt_navigator',
                    'waypoint_follower',
                ],
            }],
        ),
    ])
