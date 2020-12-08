#!/bin/bash
kubectl set env deployment/master MAP_WORKER_COUNT=100 REDUCE_WORKER_COUNT=10
echo "Waiting for master to become ready..." 
sleep 3
while [[ $(kubectl get pods -l app=master -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]]; do sleep 1; done
kubectl apply -f cloud/map/map-deploy.yaml
kubectl apply -f cloud/reduce/reduce-deploy.yaml
echo "Scaling map and reduce workers..."
kubectl scale statefulsets map --replicas=100
kubectl scale statefulsets reduce --replicas=10
echo "Waiting for master to finish..." 
sleep 3
while [[ $(kubectl get pods -l app=master -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "False" ]]; do sleep 1; done
echo "Copying metrics and results..." 
kubectl cp default/$(kubectl get pod -l app=master -o jsonpath="{.items[0].metadata.name}"):/metrics.csv 100M_10R_metrics.csv
kubectl cp default/$(kubectl get pod -l app=master -o jsonpath="{.items[0].metadata.name}"):/results.csv 100M_10R_results.csv
kubectl delete statefulset map
kubectl delete statefulset reduce
