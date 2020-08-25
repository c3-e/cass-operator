#!/usr/bin/env bash
# Script to build/push image using local
set -eo pipefail

# Build image
mage operator:buildDocker

# Tag image
image=$( docker images | grep "datastax/cass-operator" | awk '{print $3}' | head -n1 )
docker tag $image locked-registry.c3.ai/datastax/cass-operator:1.3.1

# Push image
docker push locked-registry.c3.ai/datastax/cass-operator:1.3.1
