require_relative "test_helper"

class TestApp < Fresh::Application
end

class FreshAppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    TestApp.new
  end

  def test_request
    get "/"

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
