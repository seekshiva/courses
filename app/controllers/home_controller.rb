class HomeController < ApplicationController
  def index
    if session[:user]
      @user = {name: session[:user]}
    end
    respond_to do |format|
      format.html { render "home/dashboard" }
    end
  end


  def authenticate
    begin
      @username = params[:username]
      @password = params[:password]

      imap = Net::IMAP.new("mail.nitt.edu")
      imap.login(@username, @password)
      session[:user] = @username
    rescue Net::IMAP::NoResponseError
      @failed = true
    end

    respond_to do |format|
      if @failed
        flash[:notice_type] = "alert-danger"
        format.html { redirect_to "/#login", notice: "Failed to authenticate" }
      else
        format.html { redirect_to root_url }
      end
    end
  end

  def signout
    session[:user] = nil
    redirect_to root_url
  end

end
