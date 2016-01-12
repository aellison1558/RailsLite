require 'rack'
require_relative './controllers/controller_base'
require_relative './controllers/router'
require_relative './controllers/static_assets'
require_relative './controllers/exception_handler'


router = Router.new
router.draw do

end

my_app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  router.run(req, res)
  res.finish
end

app = Rack::Builder.new do
  use ExceptionHandler
  use StaticAssets
  run my_app
end.to_app

Rack::Server.start(
 app: app,
 Port: 3000
 )
