# Dockerfile ROS2

This Dockerfile provide a ready-to-use ROS2 jazzy environment with already activated ROS2 bridge for IsaacSim

> `ROS_DOMAIN_ID` is set to 24 by default you can change it in entrypoint.sh

## Usage

### Build the image

```bash
./build_docker.sh isaacsim_humble
```

### Run the container

```bash
./run_docker.sh isaacsim_humble ros2_pkg_path1 ros2_pkg_path2 ...
```

> You can link to the container ros2 workspace as many ROS2 packages as you want which will be automatically binded to the container workspace. Note that you need to build the ROS2 packages once in the container.


## Volumes binding

A `docker` dir will be created in your home directory binding multiple volumes to the container:
- a `cache` dir to store the ROS2 packages build cache
- a `documents` dir to store you own project files
- a `exts` dir to store you own extensions

