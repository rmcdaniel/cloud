FROM ubuntu:18.04

RUN apt-get -y update && apt-get install -y net-tools iputils-ping python python-dev python-pip python-zmq

RUN python -m pip install --upgrade pip

RUN pip install --no-cache-dir couchdb

COPY mr_plugdata.py /
COPY mr_framework.py /
COPY mr_thread.py /
COPY start-master.sh /

RUN chmod a+x /start-master.sh

CMD ["/start-master.sh"]
