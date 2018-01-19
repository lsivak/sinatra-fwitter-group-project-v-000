class UsersController < ApplicationController

  get '/' do

    erb :'index'
  end

  # get '/users/:slug' do
  #   @user = User.find_by_slug(params[:slug])
  #   erb :'users/show'
  # end

    get '/signup' do

      if !session[:user_id]

      erb :'users/signup'
    else
        if @user
        session[:user_id] = @user.id
        end
           redirect to '/tweets/homepage'
    end
    end

  get '/login' do
    if !session[:user_id]
      erb :'users/login'
    else
      redirect 'tweets/homepage'
    end
  end

  post '/login' do
    @user = User.create(params[:user])
    @current_user = User.find_by_id(session[:id])

    if @current_user && User.authenticate(params[:password])
          session[:user_id] = user.id
        redirect to "/tweets/show"
      else
    erb :'users/login'

  end
  end

  post '/signup' do
    if params[:username].empty? || params[:password].empty? || params[:email].empty?
      redirect to '/signup'
    else
       @user = User.create(params[:user])
        session[:user_id] = @user.id
        @user.save

      redirect to '/tweets/homepage'
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
