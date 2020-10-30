#!/bin/bash
export BROKER_HOST=KAFKA_${HOSTNAME##*-}_SERVICE_HOST
export BROKER_PORT=KAFKA_${HOSTNAME##*-}_SERVICE_PORT
export BROKER_SERVICE_HOST=${!BROKER_HOST}
export BROKER_SERVICE_PORT=${!BROKER_PORT}
[[ -z "$BROKER_SERVICE_HOST" ]] && { echo "No external IP available" ; exit 1; }
/opt/kafka_2.13-2.5.1/bin/kafka-server-start.sh /opt/kafka_2.13-2.5.1/config/server.properties \
	--override log.dirs=/var/lib/kafka/data/topics \
	--override controlled.shutdown.enable=true \
	--override broker.id=${HOSTNAME##*-} \
	--override listeners=INTERNAL://:${KAFKA_SERVICE_PORT_INTERNAL},EXTERNAL://:${BROKER_0_SERVICE_PORT_EXTERNAL} \
	--override advertised.listeners=INTERNAL://${KAFKA_SERVICE_HOST}:${KAFKA_SERVICE_PORT_INTERNAL},EXTERNAL://${BROKER_SERVICE_HOST}:${BROKER_SERVICE_PORT} \
	--override listener.security.protocol.map=INTERNAL:PLAINTEXT,EXTERNAL:PLAINTEXT --override inter.broker.listener.name=INTERNAL \
	--override zookeeper.connect=${ZOOKEEPER_CLIENT_SERVICE_HOST}:${ZOOKEEPER_CLIENT_SERVICE_PORT}
#tail -f /dev/null
