class UsersController < ApplicationController

  get '/signup' do 
    if Helpers.is_logged_in?(session)
      user = Helpers.current_user(session)
      redirect to "/users/#{user.id}" 
    else 
      erb :'users/signup'
    end
  end 
  
  get '/login' do 
    if Helpers.is_logged_in?(session)
      user = Helpers.current_user(session)
      redirect to "/users/#{user.id}" 
    else
      erb :'users/login'
    end
  end 

  post '/login' do  
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password]) 
      session[:user_id] = user.id 
      redirect to "/users/#{user.id}"
    else  
      redirect to '/signup'
    end
  end 

  post '/signup' do 
    user = User.create(params) #(email: params[:email], username: params[:username], password: params[:password])
    if user.valid?
      session[:user_id] = user.id
      redirect to "/users/#{user.id}" #don't need @ beacuse new http request
    else  
      redirect to '/signup'
    end
  end

  get '/users/:id' do 
    if User.find_by(id: params[:id])  
      @user = User.find_by(id: params[:id])
    else  
      redirect to '/'
    end
    erb :'users/show' 
  end

end