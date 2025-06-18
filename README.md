# Fork Isaac Sim ROS & ROS2 Workspaces

This repository contains two workspaces: `humble_ws` (ROS2 Humble) and `jazzy_ws` (ROS2 Jazzy). 

[Click here for usage and installation instructions with Isaac Sim](https://docs.isaacsim.omniverse.nvidia.com/5.0.0/index.html)

When cloning this repository, both workspaces are downloaded. Depending on which ROS distro you are using, follow the [setup instructions](https://docs.isaacsim.omniverse.nvidia.com/4.5.0/installation/install_ros.html#setting-up-workspaces) for building your specific workspace.

---
## Added changes:

- We also enabled fastdds for ROS2 Bridge with Isaac Sim.
- We added a better Dockerfile for building the ROS2 workspace.


# Docker

Build the Docker image with the following command:
```bash
./ws.docker/build_docker.sh
```

Then run the Docker container with the following command:
```bash
./ws.docker/run_docker.sh
```

