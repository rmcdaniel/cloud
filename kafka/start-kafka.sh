#!/bin/bash
#/opt/kafka_2.13-2.5.1/bin/kafka-server-start.sh /opt/kafka_2.13-2.5.1/config/server.properties --override broker.id=${HOSTNAME##*-} --override listeners=PLAINTEXT://0.0.0.0:${KAFKA_SERVICE_PORT} --override advertised.listeners=PLAINTEXT://${KAFKA_SERVICE_HOST}:${KAFKA_SERVICE_PORT} --override zookeeper.connect=${ZOOKEEPER_CLIENT_SERVICE_HOST}:${ZOOKEEPER_CLIENT_SERVICE_PORT} --override controlled.shutdown.enable=true --override log.dirs=/var/lib/kafka/data/topics
tail -f /dev/null
