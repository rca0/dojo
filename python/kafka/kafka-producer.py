import sys

from confluent_kafka import Producer

import config

DATA = {
    'bootstrap.servers': config.KAFKA_BROKERS,
    'broker.version.fallback': '0.10.0.0',
    'api.version.fallback.ms': 0,
    'sasl.mechanisms': 'PLAIN',
}


if config.KAFKA_KEY and config.KAFKA_SECRET:
    data = {
        'security.protocol': 'SASL_SSL',
        'sasl.username': config.KAFKA_KEY,
        'sasl.password': config.KAFKA_SECRET,
        **DATA
    }
else:
    data = DATA


p = Producer(data)

print("Publishing message...")
if len(sys.argv) < 2:
    print("missing number of values to send")
    sys.exit(1)


def delivery_report(err, msg):
    """ Called once for each message produced to indicate delivery result.
        Triggered by poll() or flush(). """
    if err is not None:
        print('Message delivery failed: {}'.format(err))
    else:
        print('Message delivered to {} [{}]'.format(
            msg.topic(), msg.partition()))


for data in sys.argv[1:]:
    p.poll(0)
    p.produce(config.KAFKA_TOPIC, data.encode(
        'utf-8'), callback=delivery_report)
    print('data: {}'.format(data))

p.flush()
