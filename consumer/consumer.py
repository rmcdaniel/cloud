import argparse, couchdb, json, os, sys
from kafka import KafkaConsumer

def consume(topics):
	couch = couchdb.Server('http://' + os.getenv('COUCHDB_USER', '') + ':' + os.getenv('COUCHDB_PASSWORD', '') + '@' + os.getenv('COUCHDB_SERVICE_HOST', '') + ':' + os.getenv('COUCHDB_SERVICE_PORT', '') + '/')

	try:
		couch.delete('sink')
	except:
		pass

	db = couch.create('sink')

	print(db.info()['doc_count'], "records currently in the database")

	consumer = KafkaConsumer(bootstrap_servers = os.getenv('BROKER_0_SERVICE_HOST', '') + ':' + os.getenv('BROKER_0_SERVICE_PORT_INTERNAL', ''))
	consumer.subscribe(topics=topics)
	for msg in consumer:
		producer_id = msg.topic[12:]
		payload = json.loads(str(msg.value, 'ascii'))
		db.save({
			'producer_id': producer_id,
			'timestamp': payload['timestamp'],
			'contents': payload['contents'],
		})
		print("producer:", producer_id, "timestamp:", payload['timestamp'], "msg_len:", len(payload['contents']), "database_rows:", db.info()['doc_count'])

	consumer.close()
	couch.delete('sink')

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