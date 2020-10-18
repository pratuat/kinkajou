require './config/environment'

class App < Sinatra::Base
  set :logging, true
  set :views, 'app/views'

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    slim :index
  end
end