#!/usr/bin/env bash

kubectl delete cassdcs --all-namespaces --all

kubectl delete -f docs/user/cass-operator-manifests-v1.16.yaml
