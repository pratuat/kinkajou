require 'bundler'
Bundler.require(:default, ENV['RACK_ENV'])
require_all 'app'

I18n.load_path << Dir[File.expand_path("config/locales") + "/*.yml"]