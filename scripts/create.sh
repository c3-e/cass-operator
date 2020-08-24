#!/usr/bin/env bash

kubectl apply -f docs/user/cass-operator-manifests-v1.16.yaml

kubectl -n cass-operator apply -f operator/example-cassdc-yaml/cassandra-3.11.6/c3-cassdc.yaml
