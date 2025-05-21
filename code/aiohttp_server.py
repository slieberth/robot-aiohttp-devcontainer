# server.py
from aiohttp import web

routes = web.RouteTableDef()

@routes.get('/')
async def hello(request):
    return web.json_response({'message': 'Hello, world!'})

@routes.get('/user/{name}')
async def greet_user(request):
    name = request.match_info['name']
    return web.json_response({'greeting': f'Hello, {name}!'})

@routes.post('/echo')
async def echo(request):
    data = await request.json()
    return web.json_response({'you_sent': data})

app = web.Application()
app.add_routes(routes)

if __name__ == '__main__':
    web.run_app(app, port=8080)