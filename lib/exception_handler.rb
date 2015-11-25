class ExceptionHandler
  attr_reader :app

  def initialize(app)
    @app = app
  end

  def call(env)
    req = Rack::Request.new(env)
    begin
      app.call
    rescue
      print "Rescued!"
    end
  end
end
