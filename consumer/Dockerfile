FROM python:3

RUN pip install --no-cache-dir couchdb kafka-python

COPY consumer.py /

CMD ["python", "/consumer.py"]
