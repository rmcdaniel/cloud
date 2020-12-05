FROM ubuntu:18.04

RUN apt-get -y update && apt-get install -y net-tools iputils-ping python python-dev python-pip python-zmq

RUN python -m pip install --upgrade pip

COPY mr_reduceworker.py /
COPY start-reduce.sh /

CMD ["/start-reduce.sh"]
