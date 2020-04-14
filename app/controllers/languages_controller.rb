class LanguagesController < ApplicationController 
  
  get '/languages' do 
    if Helpers.is_logged_in?(session)
      @languages = Language.all
      erb :'languages/index'
    else  
      redirect '/'
    end
  end

  get '/languages/new' do 
    if !Helpers.is_logged_in?(session)
      redirect '/'
    end
    erb :'languages/new'   
  end

  post '/languages' do 
    if Helpers.is_logged_in?(session) #.id == Language.find_by(id: params[:id]).user_id
      language = Language.new(params)
      
      user = Helpers.current_user(session)
      language.user = user 
      
      if language.save 
        redirect to "/users/#{user.id}" 
      else  
        redirect '/languages/new'  
      end
    else   
      redirect '/'
    end
  end

  get '/languages/:id' do 
    @language = Language.find_by(id: params[:id])
    if !Helpers.is_logged_in?(session) || !@language
      redirect '/'
    else  
      erb :'languages/show'
    end
  end
  
  get '/languages/:id/edit' do 
    Helpers.not_logged_in? 
    @language = Language.find_by(id: params[:id])
    if !@language       
      redirect "/languages"
    end
    if @language.user != Helpers.current_user(session) 
      redirect "/users/#{Helpers.current_user(session).id}"
    end
    erb :'/languages/edit'
  end
  
  patch '/languages/:id' do 
    language = Language.find_by(id: params[:id])
    if language && language.user == Helpers.current_user(session)
      language.update(params[:language])
      redirect to "/languages/#{language.id}"
    else  
      redirect to "/languages"
    end
  end

  delete '/languages/:id/delete' do 
    language = Language.find_by(id: params[:id]) 
    if language && language.user == Helpers.current_user(session)
      language.destroy
    end 
    redirect to "/users/#{Helpers.current_user(session).id}" 
  end

end