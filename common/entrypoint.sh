#!/bin/bash
set -e

# setup ros2 environment
source "/opt/ros/$ROS_DISTRO/setup.bash" --
source "/workspace/ros2_ws/install/setup.bash" --
cd /workspace/ros2_ws
export ROS_DOMAIN_ID=24

if [ "$ENABLE_ISAAC" = "1" ]; then
    export isaac_sim_package_path=/isaac-sim
    export FASTRTPS_DEFAULT_PROFILES_FILE=/etc/fastdds.xml
    export RMW_IMPLEMENTATION=rmw_fastrtps_cpp
fi


exec "$@"