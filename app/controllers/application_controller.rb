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
  erb :'/tweets/tweets'
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
  erb :'tweets/edit'
end

get 'users/signup' do
  erb :'users/signup'
end

get 'users/login' do
  erb :'users/login'
end

post 'users/signup' do
  if !params[:users][:username].empty? || !params[:users][:password].empty? || !params[:users][:email].empty?
    redirect to '/tweets'
  end
    if Helpers.logged_in(session)?
  erb :'users/signup'
end
end

post 'users/login' do
  erb :'users/login'
end

post '/tweets' do
  @tweet = Tweet.create(params[:tweet])
  @tweet.save
  redirect to "/tweets/#{@tweet.id}"
end

post '/tweets/:id' do
  @tweet = Tweet.find(params[:id])
  @Tweet.update(params[:tweet])
  @tweet.save
  redirect to "/tweet/#{@tweet.id}"
end

post 'tweets/:id/delete' do
  @tweet.delete
  redirect to 'tweets/tweets'
end


end
