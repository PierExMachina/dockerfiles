#!/bin/bash

FOLDER=$(dirname $0)
DOCKER_PUSH=$1

f_log() {
  echo "=$1= $(date +%d/%m/%Y-%H:%M:%S) $2"
}

# Download dependencies
docker pull xataz/alpine:3.5

# Build docker-client
f_log INF "Build docker-client ..."
docker build -t tmp-build-docker-client $FOLDER > /tmp/build.log 2>&1
if [ $? == 0 ]; then
  f_log INF "Build docker-client done"
else
  f_log ERR "Build docker-client failed"
  cat /tmp/build.log
fi

for tag in $(grep "tags=" ${FOLDER}/Dockerfile | cut -d'"' -f2); do
    docker tag tmp-build-docker-client xataz/docker-client:$tag
    docker push xataz/docker-client:$tag
done

