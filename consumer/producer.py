import argparse, json, os, sys, time
from kafka import KafkaProducer
from sys import platform
from csv import reader

def produce(ip, port, data):
	producer = KafkaProducer(bootstrap_servers = ip + ":" + port, acks = 1)

	with open(data, 'r') as read_obj:
		csv_reader = reader(read_obj)
		for row in csv_reader:
			payload = json.dumps({
				'id': row[0],
				'timestamp': row[1],
				'value': row[2],
				'property': row[3],
				'plug_id': row[4],
				'household_id': row[5],
			})

			producer.send("plugs", value = bytes(payload, 'ascii'))

			producer.flush()

	producer.close()

def main(args):
	produce(str(args.ip), str(args.port), str(args.data))

if __name__ == "__main__":
	try:
			parser = argparse.ArgumentParser()
			parser.add_argument('-i', '--ip', required=True, help='kafka ip')
			parser.add_argument('-p', '--port', required=True, help='kafka port')
			parser.add_argument('-d', '--data', required=True, help='csv data file')
			main(parser.parse_args())
	except KeyboardInterrupt:
		try:
			sys.exit(0)
		except SystemExit:
			os._exit(0)
