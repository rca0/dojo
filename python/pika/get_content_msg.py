import os

import pika


pika_conn_params = pika.ConnectionParameters(
    host=os.getenv("RABBITMQ_HOSTNAME", "localhost"),
    port=os.getenv("RABBITMQ_PORT", "5672"),
    virtual_host=os.getenv("RABBITMQ_VHOST"),
    credentials=pika.credentials.PlainCredentials(
        os.getenv("RABBITMQ_USER"),
        os.getenv("RABBITMQ_PASSWORD")
    ),
)
connection = pika.BlockingConnection(pika_conn_params)
channel = connection.channel()
method_frame, header_frame, body = channel.basic_get(str(os.getenv("RABBITMQ_QUEUE_NAME")))

if method_frame:
    print(method_frame, header_frame, body)
    channel.basic_ack(method_frame.delivery_tag)
else:
    print("No message returned")
