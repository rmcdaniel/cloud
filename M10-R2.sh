#!/bin/bash
kubectl apply -f cloud/master/master-deploy.yaml
sleep 3
echo "Waiting for master to become ready..." 
while [[ $(kubectl get pods -l app=master -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]]; do sleep 1; done
kubectl apply -f cloud/map/map-deploy.yaml
kubectl apply -f cloud/reduce/reduce-deploy.yaml
echo "Scaling map and reduce workers..."
kubectl scale statefulsets map --replicas=10
kubectl scale statefulsets reduce --replicas=2
echo "Waiting for master to finish..." 
sleep 3
while [[ $(kubectl get pods -l app=master -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "False" ]]; do sleep 1; done
echo "Copying metrics and results..." 
kubectl cp default/$(kubectl get pod -l app=master -o jsonpath="{.items[0].metadata.name}"):/metrics.csv 10M_2R_metrics.csv
kubectl cp default/$(kubectl get pod -l app=master -o jsonpath="{.items[0].metadata.name}"):/results.csv 10M_2R_results.csv
kubectl delete statefulset map
kubectl delete statefulset reduce
