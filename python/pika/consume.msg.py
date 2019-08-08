
import os
import sys
import pika
import time
import config

MESSAGE = ' '.join(sys.argv[1:]) or "Hello World!"

pika_conn_params = pika.ConnectionParameters(
    host=config.RABBITMQ_HOSTNAME,
    port=config.RABBITMQ_PORT,
    virtual_host=config.RABBITMQ_VHOST,
    credentials=pika.credentials.PlainCredentials(
        config.RABBITMQ_USER,
        config.RABBITMQ_PASSWORD
    ),
)
connection = pika.BlockingConnection(pika_conn_params)

assert connection.is_open == True
print(">>> Connection is established")

channel = connection.channel()
# Consume

channel.exchange_declare(exchange='hello', exchange_type='fanout')

result = channel.queue_declare(
    queue=config.RABBITMQ_QUEUE_NAME,
    exclusive=True
)

channel.queue_bind(
    exchange='hello',
    queue=config.RABBITMQ_QUEUE_NAME
)


def callback(ch, method, properties, body):
    print(">> %r" % body)


channel.basic_consume(
    queue=config.RABBITMQ_QUEUE_NAME,
    on_message_callback=callback,
    auto_ack=True
)

channel.start_consuming()
