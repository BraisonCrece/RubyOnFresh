require "erubis"
require "fresh/file_model"

module Fresh
  class Controller
    include Fresh::Model

    def initialize(env)
      @env = env
    end

    def render(view_name, locals = {})
      filename = File.join "app", "views",
                           controller_name, "#{view_name}.html.erb"
      template = File.read filename
      eruby = Erubis::Eruby.new(template)
      eruby.result locals.merge(env: env)
    end

    def controller_name
      klass = self.class
      klass = klass.to_s.gsub(/Controller$/, "")
      Fresh.to_underscore klass
    end

    attr_reader :env
  end
end
