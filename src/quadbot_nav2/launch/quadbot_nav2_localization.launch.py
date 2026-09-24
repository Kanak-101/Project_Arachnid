"""
Launch Nav2 with a pre-built map (localization mode).

Use this AFTER you've already built and saved a map with Cartographer.
AMCL localizes against the static map; Nav2 handles navigation.

Usage:
    ros2 launch quadbot_nav2 quadbot_nav2_localization.launch.py \\
        map:=/path/to/my_map.yaml

Then use RViz2 to set initial pose (2D Pose Estimate) and navigation goals.
"""

from launch import LaunchDescription
from launch.actions import DeclareLaunchArgument
from launch.substitutions import LaunchConfiguration
from launch_ros.actions import Node
from ament_index_python.packages import get_package_share_directory
import os


def generate_launch_description():

    nav2_pkg = get_package_share_directory('quadbot_nav2')
    nav2_params_file = os.path.join(nav2_pkg, 'config', 'nav2_params.yaml')

    use_sim_time = LaunchConfiguration('use_sim_time')
    map_file = LaunchConfiguration('map')

    return LaunchDescription([

        DeclareLaunchArgument('use_sim_time', default_value='false'),
        DeclareLaunchArgument('map', default_value='',
                              description='Full path to the map YAML file'),

        # ======== Static TF ========
        Node(
            package='tf2_ros',
            executable='static_transform_publisher',
            name='base_to_laser_tf',
            arguments=['0', '0', '0', '0', '0', '0', 'base_link', 'laser'],
        ),

        # ======== RPLidar (uncomment if needed) ========
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

        # ======== cmd_vel_bridge ========
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

        # ======== Map Server ========
        Node(
            package='nav2_map_server',
            executable='map_server',
            name='map_server',
            output='screen',
            parameters=[{
                'use_sim_time': use_sim_time,
                'yaml_filename': map_file,
            }],
        ),

        # ======== AMCL Localization ========
        Node(
            package='nav2_amcl',
            executable='amcl',
            name='amcl',
            output='screen',
            parameters=[nav2_params_file, {'use_sim_time': use_sim_time}],
        ),

        # ======== Nav2 Navigation Servers ========
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

        # ======== Lifecycle Managers ========
        # Localization lifecycle (map_server + amcl)
        Node(
            package='nav2_lifecycle_manager',
            executable='lifecycle_manager',
            name='lifecycle_manager_localization',
            output='screen',
            parameters=[{
                'use_sim_time': use_sim_time,
                'autostart': True,
                'node_names': ['map_server', 'amcl'],
            }],
        ),

        # Navigation lifecycle
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
