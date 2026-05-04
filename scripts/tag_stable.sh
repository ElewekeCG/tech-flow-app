#!/bin/bash

if [ -z "$DOCKER_USERNAME" ]; then
    echo "ERROR: DOCKER_USERNAME env variable is not set"
    exit 1
fi

if ! docker inspect tech-flow > /dev/null 2>$1; then
    echo "No running container found - skipping tag_stable step."
    exit 0
fi

CURRENT_IMAGE=$(docker inspect --format='{{ .config.image }}' tech-flow)
docker tag $CURRENT_IMAGE "$DOCKER_USERNAME/tech-flow:previous_stable"
docker $DOCKER_USERNAME/tech-flow:previous_stable

echo "Stable image saved"