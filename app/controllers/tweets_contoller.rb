class TweetsController < ApplicationController

get '/tweets' do
  if session[:user_id]
    @tweets = Tweet.all
    erb :'tweets/homepage'
  else
    redirect to 'users/login'
  end
end

get '/tweets/new' do
  if session[:user_id]
    erb :'tweets/new'
  else
    redirect to 'users/login'
  end
end

post '/tweets' do
if @user.logged_in? && params[:content] == ""
  redirect to "tweets/new"
else
  user = User.find_by_id(session[:user_id])
  @tweet = Tweet.create(:content => params[:content], :user_id => user.id)
  @tweet.save
  redirect to "/tweets/#{@tweet.id}"
end
end

get '/tweets/:id' do
    if session[:user_id]
  @tweet = Tweet.find_by_id(params[:id])
  erb :'tweets/show'
else
  redirect to '/login'
end
end

get '/tweets/:id/edit' do
  if session[:user_id]
  # @tweet = Tweet.find_by_id(params[:id])
  #    if @tweet.user_id == session[:user_id]
  erb :'tweets/edit'
end
if !session[:user_id]
  redirect to '/login'
end
end

patch '/tweets/:id' do
  if params[:content] == nil
    redirect to "/tweets/#{@tweet.id}/edit"
  else
  @tweet = Tweet.find_by_id(params[:id])
  @tweet.content = Content.create(params[:content])
  @tweet.update(params[:tweet])
  @tweet.save
  redirect to "/tweets/#{@tweet.id}"
end
end

delete 'tweets/:id/delete' do
      @tweet = Tweet.find_by_id(params[:id])
          if session[:user_id]
       if @tweet.user_id == session[:user_id]
         @tweet.delete
         redirect to '/tweets/homepage'
       else
         redirect to "/tweets/homepage"
       end
     else
       redirect to "users/login"
     end
end
end
