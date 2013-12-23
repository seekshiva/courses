class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def initialize
	@user = nil
    begin
	  unless session[:user_id].nil?
		@user = User.find(session[:user_id])
	  end
	rescue
	  # session[:user_id] not found in User table
    end
  end
  
end
