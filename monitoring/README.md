# Set up monitoring using Prometheus & Grafana Operator
This monitoring instruction is only intended to provide monitoring tools to quickly use in order to get metrics for the cassandra PSR tests.
It is not the definitive solution we'll use for "production".
## Pre-requisite
You have a running Cassandra datacenter on a K8s distribution

## StorageClass
Prometheus will need a storage class that we call server-storage, you can use :
https://github.com/datastax/cass-operator/tree/master/operator/k8s-flavors

## Prometheus
Install the operator in the default namespace :
kubectl apply -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/release-0.41/bundle.yaml
Assuming the Cassandra DC has been deployed in cass-operator namespace do the following :
- kubectl apply -f prom_sa.yaml -n cass-operator
- kubectl apply -f prom_cl_role.yaml -n cass-operator
- kubectl apply -f prom_cl_role_binding.yaml -n cass-operator
- [optional] : Update selector section of service_monitor.yaml to match the labels of the cassandra DC you want to monitor
- kubectl apply -f service_monitor.yaml -n cass-operator 
- kubectl apply -f instance.yaml -n cass-operator 

## Grafana
As of now, the tested deployment uses OLM to deploy the grafana operator so you can follow the steps described :
https://docs.datastax.com/en/cass-operator/doc/cass-operator/cassOperatorMetricReporterDashboards.html#GrafanaOperatorsetup

