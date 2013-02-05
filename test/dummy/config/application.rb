require File.expand_path('../boot', __FILE__)

require "action_controller/railtie"
require "action_view/railtie"

Bundler.require
require "rack-fix-content-type"

module Dummy
  class Application < Rails::Application
    config.encoding = "utf-8"

    config.middleware.use "RackFixContentType::Middleware"
  end
end
