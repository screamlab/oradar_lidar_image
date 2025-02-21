#!/usr/bin/env python3
from launch import LaunchDescription
from launch_ros.actions import Node

def generate_launch_description():
    ordlidar_node = Node(
        package='oradar_lidar',
        executable='oradar_scan',      # 改這裡
        name='MS200',                  # 改這裡
        output='screen',
        parameters=[
            {'device_model': 'MS200'},
            {'frame_id': 'lidar'},
            {'scan_topic': '/scan'},
            {'port_name': '/dev/oradar'},
            {'baudrate': 230400},
            {'angle_min': 0.0},
            {'angle_max': 360.0},
            {'range_min': 0.05},
            {'range_max': 20.0},
            {'clockwise': False},
            {'motor_speed': 10}
        ]
    )

    base_link_to_laser_tf_node = Node(
        package='tf2_ros',
        executable='static_transform_publisher',   # 改這裡
        name='base_link_to_base_laser',            # 改這裡
        arguments=['0', '0', '0.18', '0', '0', '0', 'base_link', 'lidar']
    )

    return LaunchDescription([
        ordlidar_node,
        base_link_to_laser_tf_node
    ])
