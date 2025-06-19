#!/bin/bash
set -e

# setup ros2 environment
source "/opt/ros/$ROS_DISTRO/setup.bash" --
source "/workspace/jazzy_ws/install/setup.bash" --
cd /workspace/jazzy_ws
export ROS_DOMAIN_ID=24
exec "$@"