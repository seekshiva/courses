class HomeController < ApplicationController
  def index
    if session[:user]
      @user = session[:user]
    end
    respond_to do |format|
      format.html { render "home/dashboard" }
    end
  end
  
  def register
    @user = User.new
    if flash[:imap_id]
      flash[:imap_id] = flash[:imap_id]
      @user.email = flash[:imap_id]
      if @user.email.to_i
        @user.designation = "Student"
        begin
          @user.department_id = Department.find_by_rollno_prefix(@user.email[0..3]).id
        rescue
          @user.department_id = 0
        end
        
        @departments_array = Department.all.map do |department|
          ["#{department.name}", department.id]
        end
        
      end
    else
      redirect_to "/#login"
    end
  end

  def authenticate
    require 'net/imap'
    begin
      @username = params[:username]
      @password = params[:password]

      imap = Net::IMAP.new("mail.nitt.edu")
      imap.login(@username, @password)
      flash[:imap_id] = @username

      @user = User.find_by_email(@username)
    rescue Net::IMAP::NoResponseError
      @failed = true
    rescue
      @user = nil
    end

    respond_to do |format|
      if @failed
        flash[:notice_type] = "alert-danger"
        redirect_to "/#login", notice: "Failed to authenticate"
      else
        format.html { 
          if @user.nil?
            redirect_to "/register"
          else
            session[:user] = @user
            redirect_to root_url
          end
        }
          
        end
    end
  end
  
  def signout
    session[:user] = nil
    redirect_to root_url
  end

end
