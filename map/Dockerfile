FROM ubuntu:18.04
RUN apt-get -y update && apt-get install -y net-tools iputils-ping python python-dev python-pip python-zmq

RUN python -m pip install --upgrade pip

COPY mr_mapworker.py /
COPY start-map.sh /

RUN chmod a+x /start-map.sh

CMD ["/start-map.sh"]
