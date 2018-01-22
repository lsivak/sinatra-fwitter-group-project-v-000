class UsersController < ApplicationController

  # get '/' do
  #
  #   erb :'index'
  # end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"/users/show"
  end

    get '/signup' do
   @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
     if !session[:user_id]
      erb :'users/signup'
     else
       redirect to "/tweets"
 end
end

    post '/signup' do
      # if params[:username] =="" || params[:password] ==""|| params[:email] ==""
      if params[:username].empty? || params[:password].empty? || params[:email].empty?
        redirect 'users/signup'
      else
     user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
     user.save
     session[:user_id] = user.id
     redirect '/tweets/homepage'
   end
end

  get '/login' do
    if !session[:user_id]
      erb :'users/login'
    else
      redirect '/tweets'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect to 'users/signup'
    end
  end

  get '/logout' do
    if session[:user_id] != nil
      session.clear

      redirect to '/login'
  else
  redirect to '/'

  end

      redirect to 'tweets/homepage'
  # else
  # redirect to '/tweets/homepage'
   end


  end
