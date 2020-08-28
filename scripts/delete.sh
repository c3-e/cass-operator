#!/usr/bin/env bash
# Script to bring down cass-operator and cassdcs
set -eo pipefail

kubectl -n cass-operator delete cassdcs --all

kubectl delete -f docs/user/cass-operator-manifests-v1.16.yaml
