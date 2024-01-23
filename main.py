#! /usr/bin/env python3
#

import asyncio
import tornado

class MainHandler(tornado.web.RequestHandler):
    def read_the_news(self):
        import requests
        r = requests.get("https://example.com")
        print(r)

    def get(self):
        self.write("Hello, world!\n")
        self.read_the_news()

def make_app():
    return tornado.web.Application([
        (r"/", MainHandler),
    ])

def listen_for_sse_events():
    from sseclient import SSEClient
    messages = SSEClient('http://localhost:9080')
    for msg in messages:
        print(msg)


async def main():

    app = make_app()
    app.listen(8888)
    await asyncio.Event().wait()

    thread = Thread(target=listen_for_sse_events)
    thread.start()

if __name__ == "__main__":
    asyncio.run(main())
