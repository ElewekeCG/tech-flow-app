#!/bin/bash

URL="http://localhost:3000/health"
MAX_TRIES=5
SLEEP_SECS=5

for ((i=1; i<=MAX_TRIES; i++)); do
  echo "Attempt $i of $MAX_TRIES..."
  HTTP_STATUS=(curl -s -o /dev/null -w "%{http_code}" "$URL")
  if [ "HTTP_STATUS" -eq 200]; then
    echo "Health check passed"
    exit 0
  else
    echo "Got HTTP $HTTP_STATUS -retrying in ${SLEEP_SECS}s..."
    sleep $SLEEP_SECS
  fi
done

echo "Health check failed"
exit 1