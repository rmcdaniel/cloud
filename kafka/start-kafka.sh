#!/bin/bash
export BROKER_SERVICE_HOST_INTERNAL_ENV=BROKER_${HOSTNAME##*-}_SERVICE_HOST
export BROKER_SERVICE_PORT_INTERNAL_ENV=BROKER_${HOSTNAME##*-}_SERVICE_PORT_INTERNAL
export BROKER_SERVICE_PORT_INTERNAL_EXTERNAL_ENV=BROKER_${HOSTNAME##*-}_SERVICE_PORT_EXTERNAL
export BROKER_SERVICE_HOST_EXTERNAL_ENV=KAFKA_${HOSTNAME##*-}_SERVICE_HOST
export BROKER_SERVICE_PORT_EXTERNAL_ENV=KAFKA_${HOSTNAME##*-}_SERVICE_PORT
export BROKER_SERVICE_HOST_INTERNAL=${!BROKER_SERVICE_HOST_INTERNAL_ENV}
export BROKER_SERVICE_PORT_INTERNAL=${!BROKER_SERVICE_PORT_INTERNAL_ENV}
export BROKER_SERVICE_PORT_INTERNAL_EXTERNAL=${!BROKER_SERVICE_PORT_INTERNAL_EXTERNAL_ENV}
export BROKER_SERVICE_HOST_EXTERNAL=${!BROKER_SERVICE_HOST_EXTERNAL_ENV}
export BROKER_SERVICE_PORT_EXTERNAL=${!BROKER_SERVICE_PORT_EXTERNAL_ENV}
[[ -z "$BROKER_SERVICE_HOST_EXTERNAL" ]] && { echo "No external IP available" ; exit 1; }
/opt/kafka_2.13-2.5.1/bin/kafka-server-start.sh /opt/kafka_2.13-2.5.1/config/server.properties \
	--override log.dirs=/var/lib/kafka/data/topics \
	--override controlled.shutdown.enable=true \
	--override broker.id=${HOSTNAME##*-} \
	--override listeners=INTERNAL://:${BROKER_SERVICE_PORT_INTERNAL},EXTERNAL://:${BROKER_SERVICE_PORT_INTERNAL_EXTERNAL} \
	--override advertised.listeners=INTERNAL://${BROKER_SERVICE_HOST_INTERNAL}:${BROKER_SERVICE_PORT_INTERNAL},EXTERNAL://${BROKER_SERVICE_HOST_EXTERNAL}:${BROKER_SERVICE_PORT_EXTERNAL} \
	--override listener.security.protocol.map=INTERNAL:PLAINTEXT,EXTERNAL:PLAINTEXT --override inter.broker.listener.name=INTERNAL \
	--override zookeeper.connect=${ZOOKEEPER_SERVICE_HOST}:${ZOOKEEPER_SERVICE_PORT_CLIENT}
#tail -f /dev/null
