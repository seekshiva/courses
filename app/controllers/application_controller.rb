class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_action :setupenv

  HighVoltage.layout = 'staticpages'

  def setupenv
    @user = nil            
    begin
      unless session[:user_id].nil?
        @user = User.find(session[:user_id])
      end
    rescue
      # session[:user_id] not found in User table
    end
  end
  
  def require_user
    if @user.nil?
      respond_to do |format|
        format.html { render "home/dashboard" }
        format.json { render nothing: true , :status => 401 }
      end
    end
  end

end
