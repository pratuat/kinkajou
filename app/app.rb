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

  post '/' do
    if params[:file]
      begin
        user_locations = params[:file]['tempfile'].readlines.map {|line| JSON.parse(line)}
      rescue JSON::ParserError => exception
        return [422, {'content-type' => 'text/plain'}, 'Invalid file.']
      end

      @file_name = params[:file][:filename]

      @filtered_users_info = FilterUsersByProximityService.call(user_locations).sort_by {|user_info| user_info['name']}
    end

    slim :index
  end
end
