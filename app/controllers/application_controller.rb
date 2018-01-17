require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

get '/' do
  @tweets = Tweet.all
  erb :'/tweets/tweets'
end

get '/tweets/new'
  erb :'tweets/new'
end

get '/tweets/:id' do
  @tweet = Tweet.find(params[:id])
  erb :'tweets/show'
end

get '/tweets/:id/edit' do
  @tweet = Tweet.find(params[:id])
  erb :'tweet/edit'
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
  redirect to '/tweets/tweets'
end


end
