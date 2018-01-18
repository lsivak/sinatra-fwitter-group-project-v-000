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
  @tweet = Tweet.find(params[:id])
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
  erb :'users/login'
end

post '/signup' do
  if !params[:users][:username].empty? || !params[:users][:password].empty? || !params[:users][:email].empty?
    redirect to 'tweets/tweets'
  elsif @user
      session[:user_id] = @user.id
    erb :signup
end
end

post '/login' do
  erb :users/login
end

post '/tweets' do
  @tweet = Tweet.create(params[:tweet])
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
  @tweet.delete
  redirect to 'tweets/homepage'
end


end
