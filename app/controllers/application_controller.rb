require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "fwitter_secret"
end

get '/' do
  @tweets = Tweet.all
  erb :'/index'
end

end
