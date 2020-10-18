require 'bundler'
Bundler.require(:default, 'development')

I18n.load_path << Dir[File.expand_path("config/locales") + "/*.yml"]

require_all 'app'
