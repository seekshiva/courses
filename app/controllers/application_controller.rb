class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def current_user
    if session[:user_id]
      @user = User.find(session[:user_id])
    end
  end
  
end
