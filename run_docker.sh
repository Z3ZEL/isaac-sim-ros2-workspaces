#!/bin/bash

set -e

if [ $# -lt 1 ]; then
    echo "Usage: $0 <docker_dir_name> [folder_to_mount1] [folder_to_mount2] ..."
    exit 1
fi

DOCKER_DIR="$1.docker"
IMAGE_NAME="$1"
CONTAINER_NAME="${DOCKER_DIR}-container"
shift

xhost +

if [[ "$DOCKER_DIR" == isaacsim* ]]; then
    # Cas isaacsim : options spécifiques
    DOCKER_CMD="docker run --name ${CONTAINER_NAME} -it --gpus all -e ACCEPT_EULA=Y --rm --network=host --ipc=host \
    -v \$HOME/.Xauthority:/root/.Xauthority \
    -e DISPLAY \
    -e PRIVACY_CONSENT=Y \
    -v ~/docker/isaac-sim/cache/kit:/isaac-sim/kit/cache:rw \
    -v ~/docker/isaac-sim/cache/ov:/root/.cache/ov:rw \
    -v ~/docker/isaac-sim/cache/pip:/root/.cache/pip:rw \
    -v ~/docker/isaac-sim/cache/glcache:/root/.cache/nvidia/GLCache:rw \
    -v ~/docker/isaac-sim/cache/computecache:/root/.nv/ComputeCache:rw \
    -v ~/docker/isaac-sim/logs:/root/.nvidia-omniverse/logs:rw \
    -v ~/docker/isaac-sim/data:/root/.local/share/ov/data:rw \
    -v ~/docker/isaac-sim/documents:/root/Documents:rw \
    -v ~/docker/isaac-sim/exts:/isaac-sim/extsUser:rw"
    # Ajout des dossiers à monter
    for DIR_PATH in "$@"; do
        DIR_NAME=$(basename "$DIR_PATH")
        DOCKER_CMD="$DOCKER_CMD -v $DIR_PATH:/ros2_ws/src/$DIR_NAME"
    done
    DOCKER_CMD="$DOCKER_CMD $IMAGE_NAME bash"
else
    # Cas générique ros2
    DOCKER_CMD="docker run -it --rm -e DISPLAY=\$DISPLAY --name ${CONTAINER_NAME} --network host"
    for DIR_PATH in "$@"; do
        DIR_NAME=$(basename "$DIR_PATH")
        DOCKER_CMD="$DOCKER_CMD -v $DIR_PATH:/workspace/ros2_ws/src/$DIR_NAME"
    done
    DOCKER_CMD="$DOCKER_CMD $IMAGE_NAME bash"
fi

eval $DOCKER_CMD