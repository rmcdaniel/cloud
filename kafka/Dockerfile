FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y default-jre wget && \
    apt-get clean && \
    wget https://archive.apache.org/dist/kafka/2.5.1/kafka_2.13-2.5.1.tgz && \
    tar xvfz kafka_2.13-2.5.1.tgz -C /opt && \
    rm kafka_2.13-2.5.1.tgz

EXPOSE 9092

CMD ["/opt/kafka_2.13-2.5.1/bin/kafka-server-start.sh", "/opt/kafka_2.13-2.5.1/config/server.properties", "--override", "broker.id=0", "--override", "listeners=PLAINTEXT://0.0.0.0:9092", "--override", "advertised.listeners=PLAINTEXT://10.97.110.95:9092", "--override", "zookeeper.connect=10.96.192.144:2181"]
