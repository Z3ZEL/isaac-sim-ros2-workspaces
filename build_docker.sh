#!/bin/bash

set -e

if [ $# -lt 1 ]; then
    echo "Usage: $0 <docker_dir_name>"
    exit 1
fi

DOCKER_DIR="$1.docker"
SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" &>/dev/null && pwd)"
PROJECT_DIR="$(dirname "${SCRIPT_DIR}")"
DOCKERFILE="${SCRIPT_DIR}/${DOCKER_DIR}/Dockerfile"
TAG="$1"
DOCKER_ARGS=${@:2}

if [ ! -f "${DOCKERFILE}" ]; then
    echo "Dockerfile not found: ${DOCKERFILE}"
    exit 2
fi

echo "Building Docker image from ${DOCKERFILE} with tag ${TAG}"
docker build . --file "${DOCKERFILE}" --tag "${TAG}" ${DOCKER_ARGS}