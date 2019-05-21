import uuid

from confluent_kafka import Consumer

import config

consumer = Consumer({
    'bootstrap.servers': config.KAFKA_BROKERS,
    'broker.version.fallback': '0.10.0.0',
    'api.version.fallback.ms': 0,
    'sasl.mechanisms': 'PLAIN',
    'security.protocol': 'SASL_SSL',
    'sasl.username': config.KAFKA_KEY,
    'sasl.password': config.KAFKA_SECRET,
    # this will create a new consumer group on each invocation.
    'group.id': str(uuid.uuid1()),
    'auto.offset.reset': 'earliest'
})

consumer.subscribe([config.KAFKA_TOPIC])

print("Start Consumer...")
while True:
    msg = consumer.poll(0.5)

    if msg is None:
        continue
    if msg.error():
        print("Consumer error: {}".format(msg.error()))
        continue

    print('Received message: {}'.format(msg.value().decode('utf-8')))

consumer.close()
