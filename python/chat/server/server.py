import asyncio
import websockets
import json

CLIENTS = {}

async def write(msg):
    tasks = []
    for user in CLIENTS:
        ws = CLIENTS[user]
        tasks.append(ws.send(json.dumps(msg)))

    asyncio.gather(*tasks)


async def hello(ws, path):
    username = await ws.recv()
    CLIENTS[username] = ws
    asyncio.ensure_future(write({
        'user': 'system',
        'msg': 'User [{}] entered the chat'.format(username)
    }))
    while True:
        try:
            message = {
                'user': username,
                'msg': await ws.recv()
            }
        except websockets.ConnectionClosed:
            CLIENTS.pop(username)
            asyncio.ensure_future(write({chatchat
                'user': 'system',
                'msg': 'User [{}] has left'.format(username)
            }))
            break

        asyncio.ensure_future(write(message))

start_server = websockets.serve(hello, 'localhost', 9000)

asyncio.get_event_loop().run_until_complete(start_server)
asyncio.get_event_loop().run_forever()
