FROM ubuntu:18.04

RUN apt-get -y update && apt-get install -y net-tools iputils-ping python python-dev python-pip python-zmq

RUN python -m pip install --upgrade pip

COPY mr_plugdata.py /
COPY mr_framework.py /
COPY mr_thread.py /
COPY small.txt /

CMD ["python", "mr_plugdata.py", "-p", "5556", "-M", "1", "-R", "1", "small.txt"]
