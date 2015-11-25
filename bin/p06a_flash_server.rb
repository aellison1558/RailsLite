require 'rack'
require_relative '../lib/controller_base'
require 'byebug'

class MyController < ControllerBase
  def go
    session["count"] ||= 0
    session["count"] += 1
    flash["count"] = 0
    flash.now["hello"] = "HI"
    p flash["count"]
    p flash["hello"]
    render :counting_show
  end
end

app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  MyController.new(req, res).go
  res.finish
end

Rack::Server.start(
  app: app,
  Port: 3000
)
