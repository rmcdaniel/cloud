#!/bin/bash
# set env
export BROKER_ID=$((16#$(crc32 <(echo $(hostname))) % 1000))
export NAMESPACE=$(</var/run/secrets/kubernetes.io/serviceaccount/namespace)
export KUBE_TOKEN=$(</var/run/secrets/kubernetes.io/serviceaccount/token)
export SERVICE_ACCOUNT_CA_CERT_FILE=/var/run/secrets/kubernetes.io/serviceaccount/ca.crt
export KAFKA_SERVICE_PUBLIC_HOST=$(curl -sS http://169.254.169.254/latest/meta-data/public-hostname)
export KAFKA_SERVICE_PUBLIC_PORT=$(curl -sS --cacert $SERVICE_ACCOUNT_CA_CERT_FILE -H "Authorization: Bearer ${KUBE_TOKEN}" https://${KUBERNETES_SERVICE_HOST}/api/v1/namespaces/${NAMESPACE}/services/kafka | jq '.spec.ports[] | select(.name=="client") | .nodePort')
# run kafka
/opt/kafka_2.13-2.5.1/bin/kafka-server-start.sh /opt/kafka_2.13-2.5.1/config/server.properties --override broker.id=${BROKER_ID} --override listeners=PLAINTEXT://0.0.0.0:9092 --override advertised.listeners=PLAINTEXT://${KAFKA_SERVICE_PUBLIC_HOST}:${KAFKA_SERVICE_PUBLIC_PORT} --override zookeeper.connect=${ZOOKEEPER_SERVICE_HOST}:${ZOOKEEPER_SERVICE_PORT}
