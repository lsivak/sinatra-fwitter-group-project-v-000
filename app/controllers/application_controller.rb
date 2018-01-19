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
  erb :'tweets/new'
end

get '/tweets/:id' do
  @tweet = Tweet.find_by_id(session[:user_id])
    session[:user_id] = @user.id
  erb :'tweets/show'
end

get '/tweets/:id/edit' do
  @tweet = Tweet.find(params[:user_id])
  if logged_in(session)
  erb :'tweets/edit'
end
end

get '/signup' do
  @user = User.create(params[:user])

  erb :'users/signup'
end

get '/login' do
    @user = User.create(params[:user])
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
      #  @user.result(binding)
    redirect to 'tweets/homepage'
 end
end

post '/login' do
  @user = User.create(params[:user])
  @current_user = User.find_by_id(session[:id])
if @current_user
  session[:user_id] = @user.id
      redirect to "/tweets/show"
    else
  erb :'users/login'
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
  redirect to "/tweets/#{@user.id}"
end



post 'tweets/:user_id/delete' do
  session.clear
  redirect to '/'
end


end
