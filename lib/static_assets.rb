require 'byebug'
class StaticAssets
  attr_reader :app

  def initialize(app)
    @app = app
  end

  def call(env)
    req = Rack::Request.new(env)
    res = Rack::Response.new
    if path_matched?(req)
      res.write(File.read(req.path[1..-1]))
      res['content-type'] = 'image/png'
      res.finish
    else
      app.call(env)
    end
  end

  def path_matched?(req)
    req.path.match(/^\/public/)
  end
end
