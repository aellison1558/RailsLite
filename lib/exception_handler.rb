require_relative 'controller_base'
require 'byebug'
class ExceptionHandler
  attr_reader :app

  def initialize(app)
    @app = app
  end

  def call(env)
    req = Rack::Request.new(env)
    res = Rack::Response.new
    begin
      @app.call(env)
    rescue => exception
      print "Rescued!"
      params = {exception: exception}
      @controller = ControllerBase.new(req, res, params)
      @controller.render_shared('exception_handling')
      res.finish
    end
  end
end
