import argparse, couchdb, json, os, sys
from kafka import KafkaConsumer

def consume(topics):
	couch = couchdb.Server('http://admin:password@18.205.66.224:31903/')

	try:
		couch.delete('sink')
	except:
		pass

	db = couch.create('sink')

	print(db.info()['doc_count'], "records currently in the database")

	consumer = KafkaConsumer(bootstrap_servers = "18.205.66.224:32101")
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