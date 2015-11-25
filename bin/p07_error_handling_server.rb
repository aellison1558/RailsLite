require 'rack'
require_relative '../lib/controller_base'
require_relative '../lib/router'
require_relative '../lib/exception_handler'


$cats = [
  { id: 1, name: "Curie" },
  { id: 2, name: "Markov" }
]

$statuses = [
  { id: 1, cat_id: 1, text: "Curie loves string!" },
  { id: 2, cat_id: 2, text: "Markov is mighty!" },
  { id: 3, cat_id: 1, text: "Curie is cool!" }
]

class StatusesController < ControllerBase
  def index
    statuses = $statuses.select do |s|
      s[:cat_id] == Integer(params['cat_id'])
    end

    render_content(statuses.to_s, "text/text")
  end
end

class Cats2Controller < ControllerBase
  def index
    render_content($cats.to_s, "text/text")
  end
end

router = Router.new
router.draw do
  get Regexp.new("^/cats$"), Cats2Controller, :index
  get Regexp.new("^/cats/(?<cat_id>\\d+)/statuses$"), StatusesController, :index
end

my_app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  router.run(req, res)
  res.finish
end

class MyController < ControllerBase
  def go
    session["count"] ||= 0
    session["count"] += 1
    flash["count"] = 0
    flash.now["hello"] = "HI"
    render :counting_show
  end
end

another_app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  MyController.new(req, res, {}).go
  res.finish
end

app = Rack::Builder.new do
  use ExceptionHandler
  run my_app
end.to_app

Rack::Server.start(
 app: app,
 Port: 3000
)
