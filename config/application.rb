require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Myproject
  class Application < Rails::Application
    #react_js
    config.react.server_renderer_pool_size  ||= 1  # ExecJS doesn't allow more than one on MRI
    config.react.server_renderer_timeout    ||= 20 # seconds
    config.react.server_renderer = React::ServerRendering::SprocketsRenderer
    config.react.server_renderer_options = {
      files: ["react-server.js", "components.js"], # files to load for prerendering
      replay_console: true,                 # if true, console.* will be replayed client-side
    }
    # Bower asset paths

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    Datagrid.configure do |config|

      # Defines date formats that can be used to parse date.
      # Note that multiple formats can be specified but only first format used to format date as string. 
      # Other formats are just used for parsing date from string in case your App uses multiple.
      config.date_formats = ["%m/%d/%Y", "%Y-%m-%d"]

      # Defines timestamp formats that can be used to parse timestamp.
      # Note that multiple formats can be specified but only first format used to format timestamp as string. 
      # Other formats are just used for parsing timestamp from string in case your App uses multiple.
      config.datetime_formats = ["%m/%d/%Y %h:%M", "%Y-%m-%d %h:%M:%s"]
    end

 end
end
