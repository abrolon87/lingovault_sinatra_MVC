class LanguagesController < ApplicationController 
  
  get '/languages' do 
    @languages = Language.all
    erb :'languages/index'
  end

  get '/languages/new' do 
    if !Helpers.is_logged_in?(session)
      redirect '/'
    end
    erb :'languages/new'   
  end

  post '/languages/new' do 
    if Helpers.current_user(session).id == Language.find_by(id: params[:id]).user_id
    language = Language.create(params)
    user = Helpers.current_user(session)
    language.user = user 
    language.save
    redirect to "/users/#{user.id}"
    end
  end

  get '/languages/:id' do 
    if !Helpers.is_logged_in?(session)
      redirect '/'
    end
    @language = Language.find_by(id: params[:id])
    if !@language 
      redirect to '/' 
    end
    erb :'languages/show'
  end
  
  get '/languages/:id/edit' do 
    @language = Language.find_by(id: params[:id])
    if !Helpers.is_logged_in?(session) || @language.user != Helpers.current_user(session) 
      redirect '/'
    end
    erb :'/languages/edit'
  end
  
  patch '/languages/:id' do 
    language = Language.find_by(id: params[:id])
    language.update(params[:language])
    redirect to "/languages/#{language.id}"
  end
end