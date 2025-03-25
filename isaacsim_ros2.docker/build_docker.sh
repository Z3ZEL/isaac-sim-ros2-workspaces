#!/bin/bash

# Build the Docker image
SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" &>/dev/null && pwd)"
PROJECT_DIR="$(dirname "${SCRIPT_DIR}")"
TAG="nis-ros2-bridge"
DOCKERFILE="${SCRIPT_DIR}/Dockerfile"
echo $PROJECT_DIR
DOCKER_BUILD_CMD=(docker build "${PROJECT_DIR}" --file "${DOCKERFILE}" --tag ${TAG})

echo -e "\033[0;32m${DOCKER_BUILD_CMD[*]}\033[0m" | xargs

# shellcheck disable=SC2068
exec ${DOCKER_BUILD_CMD[*]}
