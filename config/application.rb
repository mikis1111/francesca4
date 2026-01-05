require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SitoDietologa
  class Application < Rails::Application
    config.time_zone = "Europe/Rome"
    config.active_record.default_timezone = :utc

    config.load_defaults 7.1

    # 🌍 I18n
    config.i18n.default_locale = :it
    config.i18n.available_locales = [:it, :en]
    config.i18n.fallbacks = true
  end
end
