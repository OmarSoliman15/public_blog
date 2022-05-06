require 'yaml'
require "./lib/boot"

class Application
  attr_reader :router

  def initialize 
    @router = Router.new(ROUTES)
  end

  def call(env)
    result = router.resolve(env)
    [result.status, result.headers, result.content]
  end
end
