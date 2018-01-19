class UsersController < ApplicationController

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

  get '/logout' do
    if session[:user_id] =! nil
      session.destroy
      redirect to '/login'
  else
  redirect to '/'
  end
  end
  end
