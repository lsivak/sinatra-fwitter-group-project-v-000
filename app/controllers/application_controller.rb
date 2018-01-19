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
  erb :'tweets/homepage'
end

get '/tweets/new' do
  if session[:user_id]
    erb :'tweets/new'
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

get '/users/:slug' do
  @user = User.find_by_slug(params[:slug])
  erb :'users/show'
end

get '/login' do
  if !session[:user_id]
    erb :'users/login'
  else
    redirect '/tweets'
  end
end

post '/login' do
  @user = User.create(params[:user])
  @current_user = User.find_by_id(session[:id])
if @current_user
  if user && user.authenticate(params[:password])
        session[:user_id] = user.id
      redirect to "/tweets/show"
    else
  erb :'users/login'
end
end
ends

get '/signup' do
  if !session[:user_id]

  erb :'users/signup'
else
  redirect to '/tweets'
end
end

post '/signup' do
  if params[:username].empty? || params[:password].empty? || params[:email].empty?
    redirect to 'users/signup'
  else
     @user = User.create(params[:user])
      session[:user_id] = @user.id
      @user.save

    redirect to 'tweets/homepage'
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

get '/logout' do
  if session[:user_id] =! nil
    session.destroy
    redirect to '/login'
else
redirect to '/'
end
end
end
