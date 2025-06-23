# Fork Isaac Sim ROS & ROS2 Workspaces

This repository contains two workspaces: `humble_ws` (ROS2 Humble) and `jazzy_ws` (ROS2 Jazzy). 

[Click here for usage and installation instructions with Isaac Sim](https://docs.isaacsim.omniverse.nvidia.com/5.0.0/index.html)

When cloning this repository, both workspaces are downloaded. Depending on which ROS distro you are using, follow the [setup instructions](https://docs.isaacsim.omniverse.nvidia.com/4.5.0/installation/install_ros.html#setting-up-workspaces) for building your specific workspace.

---
# Custom changes:

- We also enabled fastdds for ROS2 Bridge with Isaac Sim.
- We added a better Dockerfile for building the ROS2 workspace.

## Workspaces

### [Humble Workspace](ros2_humble.docker/README.md)
```bash
./run_docker.sh ros2_humble 
```
### [Jazzy Workspace](ros2_jazzy.docker/README.md)
```bash
./run_docker.sh ros2_jazzy
```
### [IsaacSim Humble Workspace](isaacsim_humble.docker/README.md)
```bash
./run_docker.sh isaacsim_humble
```

## Embedded Commands and Features

### Commands
- `rid <number>` : Change the ROS_DOMAIN_ID to the specified number.
- `launch_isaacsim` : Launch Isaac Sim with the ROS2 bridge enabled (only for isaacsim workspaces).
### Features

- **Adding ROS2 Packages**: You can add ROS2 packages to src directory by adding the path to the `run_docker.sh` command. For example:
```bash
./run_docker.sh ros2_humble /path/to/your/ros2_package
```




# Docker

Build the Docker image with the following command:
```bash
./build_docker.sh docker_workspace
```

Then run the Docker container with the following command:
```bash
./run_docker.sh docker_workspace
```

> Docker workspace name are the name of the directory without the `.docker`

