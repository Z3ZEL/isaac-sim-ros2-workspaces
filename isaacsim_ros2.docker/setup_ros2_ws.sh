#!/bin/bash

source /opt/ros/humble/setup.sh
cd /ros2_ws
rosdep init
rosdep update
rosdep install --from-paths src --ignore-src -r -y
colcon build --cmake-args -DPython3_EXECUTABLE=/usr/bin/python3.10 --merge-install
source /ros2_ws/install/setup.sh