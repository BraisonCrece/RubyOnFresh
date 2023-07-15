# frozen_string_literal: true

require "fresh/dependencies"
require "fresh/controller"
require "fresh/version"
require "fresh/routing"
require "fresh/array"
require "fresh/util"
require "json"

module Fresh
  class Error < StandardError; end

  class Application
    def call(env)
      # the browser automaticly request for the favicon
      # but for now we are not going to care about
      # so... :)
      if env["PATH_INFO"] == "/favicon.ico"
        return [
          404,
          {"Content-Type" => "text/html"},
          []
        ]
      end

      if env["PATH_INFO"] == "/"
        return [
          302,
          {"Location" => "http://localhost:3001/quotes/a_quote"},
          [""]
        ]
      end

      klass, act = get_controller_and_action(env)
      controller = klass.new(env)
      begin
        text = controller.send(act)
      rescue => exception
        return [
          404,
          {"Content-Type" => "text/html"},
          [exception.to_s]
        ]
      end
      [
        # status code
        200,
        # Headers
        {"Content-Type" => "text/html"},
        # Content
        [text]
      ]
    end
  end

  class Controller
    attr_reader :env

    def initialize(env)
      @env = env
    end
  end
end
