import argparse, json, os, sys
from kafka import KafkaConsumer

def consume(topics):
	consumer = KafkaConsumer(bootstrap_servers = "3.238.122.116:31823")
	consumer.subscribe(topics=topics)
	for msg in consumer:
		producer_id = msg.topic[12:]
		payload = json.loads(str(msg.value, 'ascii'))
		print("producer:", producer_id, "timestamp:", payload['timestamp'], "msg_len:", len(payload['contents']))

	consumer.close()

def main(args):
	topics = []
	for id in args.ids:
		topics.append("utilizations" + str(id))
	consume(topics)

if __name__ == "__main__":
	try:
		parser = argparse.ArgumentParser()
		parser.add_argument('-i', '--ids', required=True, nargs='+', help='ids of producers to listen for')
		main(parser.parse_args())
	except KeyboardInterrupt:
		try:
			sys.exit(0)
		except SystemExit:
			os._exit(0)
