"""
Launch RViz2 with the quadbot Nav2 display config.

Usage:
    ros2 launch quadbot_nav2 rviz.launch.py
"""

from launch import LaunchDescription
from launch_ros.actions import Node
from ament_index_python.packages import get_package_share_directory
import os


def generate_launch_description():
    nav2_pkg = get_package_share_directory('quadbot_nav2')
    rviz_config = os.path.join(nav2_pkg, 'config', 'nav2_rviz.yaml')

    return LaunchDescription([
        Node(
            package='rviz2',
            executable='rviz2',
            name='rviz2',
            output='screen',
            arguments=['-d', rviz_config],
        ),
    ])
