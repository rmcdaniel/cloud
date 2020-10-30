import argparse, json, os, sys, time
from kafka import KafkaProducer
from sys import platform

def produce(topic):
	producer = KafkaProducer(bootstrap_servers = "3.238.122.116:30455", acks = 1)

	for i in range(100):
		if platform == "darwin":
			process = os.popen("top -n 1 -l 1")
		else:
			process = os.popen("top -n 1 -b")

		timestamp = time.strftime("%Y-%m-%d %H:%M:%S+00:00 (UTC)", time.gmtime())

		contents = process.read()

		payload = json.dumps({
			'timestamp': timestamp,
			'contents': contents
			})

		print("producer:", topic[12:], "timestamp:", timestamp, "msg_len:", len(contents))

		producer.send(topic, value = bytes(payload, 'ascii'))

		producer.flush()

		time.sleep(1)

	producer.close()

def main(args):
	produce("utilizations" + str(args.id))

if __name__ == "__main__":
	try:
			parser = argparse.ArgumentParser()
			parser.add_argument('-i', '--id', required=True, help='id of producer')
			main(parser.parse_args())
	except KeyboardInterrupt:
		try:
			sys.exit(0)
		except SystemExit:
			os._exit(0)
