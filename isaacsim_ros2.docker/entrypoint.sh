#!/bin/bash
set -e

# setup ros2 environment
source "/opt/ros/$ROS_DISTRO/setup.bash" --
#source "/ros2_ws/install/setup.bash" --
source "/.bashrc" --
export isaac_sim_package_path=/isaac-sim
export FASTRTPS_DEFAULT_PROFILES_FILE=/etc/fastdds.xml
export RMW_IMPLEMENTATION=rmw_fastrtps_cpp
export ROS_DOMAIN_ID=24
exec "$@"

# Run Isaac Sim
# $isaac_sim_package_path/isaac-sim.selector.sh