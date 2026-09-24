from launch import LaunchDescription
from launch_ros.actions import Node
from ament_index_python.packages import get_package_share_directory
import os


def generate_launch_description():

    pkg_dir = get_package_share_directory('quadbot_cartographer')
    config_dir = os.path.join(pkg_dir, 'config')

    return LaunchDescription([

        Node(
            package='cartographer_ros',
            executable='cartographer_node',
            name='cartographer_node',
            output='screen',
            parameters=[{
                'use_sim_time': False,
            }],
            arguments=[
                '-configuration_directory', config_dir,
                '-configuration_basename', 'quadbot.lua',
            ],
            remappings=[
                ('scan', '/scan'),
            ],
        ),

        Node(
            package='cartographer_ros',
            executable='cartographer_occupancy_grid_node',
            name='cartographer_occupancy_grid_node',
            output='screen',
            parameters=[{
                'use_sim_time': False,
            }],
            arguments=[
                '-resolution', '0.05',
                '-publish_period_sec', '1.0',
            ],
        ),

        Node(
            package='tf2_ros',
            executable='static_transform_publisher',
            name='base_to_laser',
            arguments=[
                '0', '0', '0',
                '0', '0', '0',
                'base_link',
                'laser'
            ],
        ),
    ])
