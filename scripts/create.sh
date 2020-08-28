#!/usr/bin/env bash
# Script to use local manifests to bring up cass-operator
set -eo pipefail

kubectl apply -f docs/user/cass-operator-manifests-v1.16.yaml

sleep 10

kubectl -n cass-operator apply -f usage/eks/c3-cassdc.yaml
