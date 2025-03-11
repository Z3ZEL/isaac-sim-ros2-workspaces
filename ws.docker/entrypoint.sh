#!/bin/bash
set -e

# setup ros2 environment
source "/opt/ros/$ROS_DISTRO/setup.bash" --
source "/workspace/humble_ws/install/setup.bash" --
cd /workspace/humble_ws
exec "$@"