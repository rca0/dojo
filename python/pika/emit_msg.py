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

channel.exchange_declare(exchange='hello', exchange_type='fanout')

channel.basic_publish(
    exchange='hello',
    routing_key='hello',
    body=MESSAGE,
    properties=pika.BasicProperties(
        delivery_mode = 2, # make message persistent
    )
)

print(">>> Sent message: {}".format(MESSAGE))

connection.close()
