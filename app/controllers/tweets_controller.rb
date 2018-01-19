class TweetsController < ApplicationController


get '/' do
  @tweets = Tweet.all
  erb :'/'
end

get '/tweets/new' do
  erb :'tweets/new'
end

get '/tweets/:id' do
  @tweet = Tweet.find_by_id(session[:user_id])
    session[:user_id] = @user.id
  erb :'tweets/show'
end

get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(session[:user_id])
  if logged_in(session)
  erb :'tweets/edit'
end

post '/tweets/:id' do
  @tweet = Tweet.find(params[:id])
  @tweet.update(params[:tweet])
  @tweet.save
  redirect to "/tweets/#{@tweet.id}"
end

end
post '/tweets' do
  @tweet = Tweet.create(params[:tweet])
  @tweet.content = params[:content]
  @tweet.save
  redirect to "/tweets/#{@tweets.id}"
end

post 'tweets/:id/delete' do
  session.clear
  redirect to '/'
end
end
