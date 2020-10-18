require 'bundler'
Bundler.require(:default, 'development')
require_all 'app'

I18n.load_path << Dir[File.expand_path("config/locales") + "/*.yml"]