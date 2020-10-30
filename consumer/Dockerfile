FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y default-jre wget && \
    apt-get clean && \
    wget https://archive.apache.org/dist/kafka/2.5.1/kafka_2.13-2.5.1.tgz && \
    tar xvfz kafka_2.13-2.5.1.tgz -C /opt && \
    rm kafka_2.13-2.5.1.tgz
    
COPY ~/consumer.py /root/

EXPOSE 9092

CMD ["python3 /root/consumer.py -i 2 3 4"]
