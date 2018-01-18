require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "secret"
end

get '/' do
  @tweets = Tweet.all
  erb :'/tweets/homepage'
end

get '/tweets/new' do
  erb :'tweets/new'
end

get '/tweets/:id' do
  @tweet = Tweet.find_by_id(session[:user_id])
  erb :'tweets/show'
end

get '/tweets/:id/edit' do
  @tweet = Tweet.find(params[:id])
  if logged_in(session)
  erb :'tweets/edit'
end
end

get '/signup' do
  @user = User.create(params[:user])
  erb :'users/signup'
end

get '/login' do
#   @current_user = User.find_by_id(session[:user_id])
# if @current_user
  erb :'users/login'
# end
end

post '/signup' do
  if params[:username].empty? || params[:password].empty? || params[:email].empty?
    redirect to 'users/signup'
  else
     @user = User.create(params[:user])
      session[:user_id] = @user.id
      # @user.result(binding)
    redirect to 'tweets/show'
 end
end

post '/login' do
  @current_user = User.find_by_id(session[:user_id])
if @current_user
  erb :'users/login'
end
end
post '/tweets' do
  @tweet = Tweet.create(params[:tweet])
  @tweet.contents = params[:contents]
  @tweet.save
  redirect to "/tweets/#{@tweet.id}"
end

post '/tweets/:id' do
  @tweet = Tweet.find(params[:id])
  @tweet.update(params[:tweet])
  @tweet.save
  redirect to "/tweets/#{@tweet.id}"
end

post 'tweets/:id/delete' do
  @tweet.clear
  redirect to '/'
end


end
