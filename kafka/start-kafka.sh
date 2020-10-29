#!/bin/bash
# set env
export BROKER_ID=1
export KAFKA_SERVICE_PUBLIC_HOST=
export KAFKA_SERVICE_PUBLIC_PORT=
export ZOOKEEPER_HOST=
export ZOOKEEPER_PORT=2181
# run kafka
#/opt/kafka_2.13-2.5.1/bin/kafka-server-start.sh /opt/kafka_2.13-2.5.1/config/server.properties --override broker.id=${BROKER_ID} --override listeners=PLAINTEXT://0.0.0.0:9092 --override advertised.listeners=PLAINTEXT://:9092 --override zookeeper.connect=${ZOOKEEPER_HOST}:${ZOOKEEPER_PORT} --override controlled.shutdown.enable=true
tail -f /dev/null
