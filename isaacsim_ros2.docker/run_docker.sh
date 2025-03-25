#!/bin/bash
xhost +

# Initialize an empty string for directory arguments
DIR_ARGS=""

# Iterate over all arguments (paths to folders), skipping the first one
for DIR_PATH in "$@"; do
    # Append the volume mount option to the directory arguments
    DIR_ARGS="$DIR_ARGS -v $DIR_PATH:/ros2_ws/src/$(basename $DIR_PATH)"
done

docker run --name nis-ros2-bridge-container -it --gpus all -e "ACCEPT_EULA=Y" --rm --network=host --ipc=host \
-v $HOME/.Xauthority:/root/.Xauthority \
-e DISPLAY \
-e "PRIVACY_CONSENT=Y" \
-v ~/docker/isaac-sim/cache/kit:/isaac-sim/kit/cache:rw \
-v ~/docker/isaac-sim/cache/ov:/root/.cache/ov:rw \
-v ~/docker/isaac-sim/cache/pip:/root/.cache/pip:rw \
-v ~/docker/isaac-sim/cache/glcache:/root/.cache/nvidia/GLCache:rw \
-v ~/docker/isaac-sim/cache/computecache:/root/.nv/ComputeCache:rw \
-v ~/docker/isaac-sim/logs:/root/.nvidia-omniverse/logs:rw \
-v ~/docker/isaac-sim/data:/root/.local/share/ov/data:rw \
-v ~/docker/isaac-sim/documents:/root/Documents:rw \
-v ~/docker/isaac-sim/exts:/isaac-sim/extsUser:rw \
$DIR_ARGS \
nis-ros2-bridge:latest