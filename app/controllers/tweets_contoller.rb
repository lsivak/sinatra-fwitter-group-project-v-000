class TweetsController < ApplicationController
  #
  # get '/' do
  #   @tweets = Tweet.all
  #   erb :'/index'
  # end

get '/tweets' do
  if session[:user_id]
    @tweets = Tweet.all
    erb :'tweets/homepage'
  else
    redirect to '/login'
  end
end

get '/tweets/:id' do
  @tweet = Tweet.find_by_id(session[:user_id])
    if session[:user_id] = @user.id
  erb :'tweets/show'
else
  redirect to '/login'
end
end

get '/tweets/:id/edit' do
  @tweet = Tweet.find_by_id(params[:id])
     if @tweet.user_id == session[:user_id]
  erb :'tweets/edit'
else
  redirect to '/login'

end
end

post '/tweets/:id' do
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

post '/tweets' do
if params[:content] == nil
  redirect to "tweets/new"
else
  user = User.find_by_id(session[:user_id])
  @tweet = Tweet.create(:content => params[:content], :user_id => user.id)
  redirect to "/tweets/#{@tweet.id}"
end
end


post 'tweets/:id/delete' do
    if session[:user_id]
      @tweet = Tweet.find_by_id(params[:id])
       if @tweet.user_id == session[:user_id]
         @tweet.delete
         redirect to '/tweets'
       else
         redirect to '/tweets'
       end
     else
       redirect to '/login'
     end
end
end
