xhost +
docker run -it --rm -e DISPLAY=$DISPLAY --name isaac-sim-ros2-container --network host isaac-sim-ros2 bash
