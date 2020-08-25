#!/usr/bin/env bash
# Script to bring down cass-operator and cassdcs
set -eo pipefail

kubectl delete cassdcs --all-namespaces --all

kubectl delete -f docs/user/cass-operator-manifests-v1.16.yaml
