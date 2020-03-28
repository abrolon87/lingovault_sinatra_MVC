class UsersController < ApplicationController

  get '/signup' do 
    erb :'users/signup'
  end 

  post '/users' do 
    user = User.create(params) #(email: params[:email], username: params[:username], password: params[:password])
    session[:user_id] = user.id
    redirect to "/users/#{user.id}" #don't need @ beacuse new http request
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