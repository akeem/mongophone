# Check out https://github.com/joshbuddy/http_router for more information on HttpRouter
HttpRouter.new do
  add('/').to(HomeAction)
  add('/db/:name').to(MongoAction)
  add('server').to(ServerAction)
end
