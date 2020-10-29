FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y default-jre wget && \
    apt-get clean && \
    wget https://archive.apache.org/dist/kafka/2.5.1/kafka_2.13-2.5.1.tgz && \
    tar xvfz kafka_2.13-2.5.1.tgz -C /opt && \
    rm kafka_2.13-2.5.1.tgz

COPY server.properties /opt/kafka_2.13-2.5.1/config/server.properties

RUN sed "s/{BROKER_ID}/0/g" -i /opt/kafka_2.13-2.5.1/config/server.properties && \
    sed "s/{LISTENER_ADDRESS}/$(hostname -i)/g" -i /opt/kafka_2.13-2.5.1/config/server.properties && \
    sed "s/{ZOOKEEPER_ADDRESS}/10.96.64.18/g" -i /opt/kafka_2.13-2.5.1/config/server.properties

EXPOSE 9092

CMD ["/opt/kafka_2.13-2.5.1/bin/kafka-server-start.sh", "/opt/kafka_2.13-2.5.1/config/server.properties"]
