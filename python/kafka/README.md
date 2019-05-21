# Sample kafka debug


## Environment settings:

ENV | VALUE
--- | ---
KAFKA_TOPIC | TOPIC_NAME
KAFKA_BROKERS | ["kafka-broker1:9092","kafka-broker2:9092"]
KAFKA_USERNAME | ccloud key
KAFKA_PASSWORD | ccloud password

## Usage

Start consumer: `python kafka-consumer`

Publishing message: `python kafka-producer.py testing-kafka`
