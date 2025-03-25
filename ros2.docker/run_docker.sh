xhost +

# Initialize the docker run command
DOCKER_CMD="docker run -it --rm -e DISPLAY=\$DISPLAY --name isaac-sim-ros2-container --network host"

# Iterate over all arguments (paths to folders)
for DIR_PATH in "$@"; do
    # Extract the directory name from the path
    DIR_NAME=$(basename "$DIR_PATH")
    # Append the volume mount option to the docker command
    DOCKER_CMD="$DOCKER_CMD -v $DIR_PATH:/workspace/humble_ws/src/$DIR_NAME"
done

# Append the image name and command to run inside the container
DOCKER_CMD="$DOCKER_CMD isaac-sim-ros2 bash"

# Execute the docker command
eval $DOCKER_CMD