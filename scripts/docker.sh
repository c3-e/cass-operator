#!/usr/bin/env bash
# Script to build/push image using local
set -eo pipefail

imagename=ci-registry.c3iot.io/preview/cass-operator:1.5.0

# Build image
mage operator:buildDocker

# Tag image
imagehash=$( docker images | grep "datastax/cass-operator" | awk '{print $3}' | head -n1 )
docker tag $imagehash $imagename

# Push image
docker push $imagename
