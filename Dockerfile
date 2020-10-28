FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y default-jre && \
    apt-get clean && \
    wget https://archive.apache.org/dist/kafka/2.5.1/kafka_2.13-2.5.1.tgz && \
    tar xvfz *.tgz && \
    rm *.tgz

EXPOSE 2181 2888 3888

CMD ["./bin/zookeeper-server-start.sh", "-daemon config/zookeeper.properties"]
