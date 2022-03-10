require 'i18n'
require_relative '../lib/bot'

I18n.load_path = Dir['config/locales/*.yml']
I18n.backend.load_translations

Bot.new
