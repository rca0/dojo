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
queue = channel.queue_declare(
    queue=str(os.getenv("RABBITMQ_QUEUE_NAME")), 
    durable=True,
    exclusive=False, 
    auto_delete=False,
)

print(queue.method.message_count)
