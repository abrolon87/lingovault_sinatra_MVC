class Helpers 

  def self.current_user(session)  
    current_user ||= User.find_by(id: session[:user_id]) 
  end 

  def self.is_logged_in?(session)
    !!self.current_user[:user_id]   
  end
  
  def self.not_logged_in?
    if !Helpers.is_logged_in?(session) 
      redirect '/'
    end
  end

end 