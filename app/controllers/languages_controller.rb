class LanguagesController < ApplicationController 
  
  get '/languages/new' do 
    erb :'languages/new'   
  end

  post '/languages' do 
    language = Language.create(params)
    user = Helpers.current_user(session)
    language.user = user 
    langauge.save
    redirect to "/users/#{user.id}"
  end


end