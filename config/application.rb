require File.expand_path('../boot', __FILE__)

unless File.exists? 'config/api_keys.yml'
  FileUtils.cp 'config/api_keys.yml.template', 'config/api_keys.yml'
end

unless File.exists? 'config/database.yml'
  FileUtils.cp 'config/database.yml.template', 'config/database.yml'
end
  
require 'rails/all'
require 'yaml'

APP_CONFIG = YAML.load(File.read(File.expand_path('../app_config.yml', __FILE__)))
API_KEYS = YAML.load(File.read(File.expand_path('../api_keys.yml', __FILE__)))[Rails.env]

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Adoberep
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.autoload_paths += Dir["#{config.root}/lib/**/"]

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    #config.i18n.default_locale = :es
  end
end
