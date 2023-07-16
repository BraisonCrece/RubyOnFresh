require_relative "test_helper"

class TestController < Fresh::Controller
  def index
    "Hello!" # Not rendering a view
  end
end

class TestApp < Fresh::Application
  def get_controller_and_action(env)
    [TestController, "index"]
  end
end

class FreshAppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    TestApp.new
  end

  def test_request
    get "/example/route"

    assert last_response.ok?
    body = last_response.body

    assert body["Hello"]
  end

  def test_deeply_empty_method
    arr = []
    4.times { arr << [] }
    assert arr.deeply_empty? == true
  end
end
