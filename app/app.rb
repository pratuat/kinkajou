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

  post '/filter_customers' do
    content = params[:file]['tempfile'].read

    [200, {}, 'Success']
  end
end
