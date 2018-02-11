require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Flamethrower
  class Application < Rails::Application
    config.api_only = true
    config.load_defaults 5.1
    config.autoload_paths << Rails.root.join('lib')
  end
end
