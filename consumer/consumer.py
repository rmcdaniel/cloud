import argparse, couchdb, json, os, sys
from kafka import KafkaConsumer

def consume():
	couch = couchdb.Server('http://' + os.getenv('COUCHDB_USER', '') + ':' + os.getenv('COUCHDB_PASSWORD', '') + '@' + os.getenv('COUCHDB_SERVICE_HOST', '') + ':' + os.getenv('COUCHDB_SERVICE_PORT', '') + '/')

	try:
		couch.delete('plugs')
	except:
		pass

	db = couch.create('plugs')

	consumer = KafkaConsumer(bootstrap_servers = os.getenv('BROKER_0_SERVICE_HOST', '') + ':' + os.getenv('BROKER_0_SERVICE_PORT_INTERNAL', ''))
	consumer.subscribe(topics=["plugs"])
	for msg in consumer:
		producer_id = msg.topic[12:]
		payload = json.loads(str(msg.value, 'ascii'))
		db.save({
			'id': payload['id'],
			'timestamp': payload['timestamp'],
			'value': payload['value'],
			'property': payload['property'],
			'plug_id': payload['plug_id'],
			'household_id': payload['household_id'],
		})

	consumer.close()
	couch.delete('plugs')

def main(args):
	consume()

if __name__ == "__main__":
	try:
		parser = argparse.ArgumentParser()
		main(parser.parse_args())
	except KeyboardInterrupt:
		try:
			sys.exit(0)
		except SystemExit:
			os._exit(0)