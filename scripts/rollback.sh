#!/bin/bash

echo "initiating rollback.."

if ! sudo docker pull $DOCKER_USERNAME/tech-flow:previous; then
  echo "No previous image found, skipping rollback"
  exit 1
fi
docker stop tech-flow || true
docker rm tech-flow || true
# docker pull "$DOCKER_USERNAME/tech-flow:previous_stable"

docker run -d  \
    -p 3000:3000 \
  --name tech-flow \
  --restart unless-stopped \
  "$DOCKER_USERNAME/tech-flow:previous_stable"
if bash /home/ubuntu/scripts/health_check.sh; then
    echo "Rollback successful"
    exit 0
else
    echo "Rollback failed - manual intervention required"
    exit 1
fi