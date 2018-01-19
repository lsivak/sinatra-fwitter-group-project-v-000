class UsersController < ApplicationController

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
end
