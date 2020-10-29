FROM ubuntu:18.04

COPY start-kafka.sh /

RUN apt-get update && \
    apt-get install -y default-jre curl jq && \
    apt-get clean && \
    curl -sS https://archive.apache.org/dist/kafka/2.5.1/kafka_2.13-2.5.1.tgz -o kafka_2.13-2.5.1.tgz && \
    tar xvfz kafka_2.13-2.5.1.tgz -C /opt && \
    rm kafka_2.13-2.5.1.tgz && \
    chmod a+x /start-kafka.sh

EXPOSE 9092

CMD ["/start-kafka.sh"]
