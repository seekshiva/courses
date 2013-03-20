class HomeController < ApplicationController
  def index
    if session[:user_id]
      @user = User.find(session[:user_id])
    end
    respond_to do |format|
      format.html { render "home/dashboard" }
    end
  end
  
  def me
    @user = User.find_by_email(flash[:imap_id])
    if @user.nil?
      @user = User.new
    end

    if flash[:imap_id]
      flash[:imap_id] = flash[:imap_id]
      @user[:email] = flash[:imap_id]
      
      if @user.is_student?
        begin
          @user.department_id = Department.find_by_rollno_prefix(@user[:email][0..3]).id
        rescue
          @user.department_id = 0
        end

        @departments_array = Department.all.map do |department|
          ["#{department.name}", department.id]
        end
        
        @course_list = []
        Course.all.each do |course|
          if not course.current_term.nil? and (course.current_term.semester+1)/2 == @user.nth_year
            course.departments.each do |dept|
              if dept.id == @user.department_id 
                @course_list << course
              end
            end
          end
        end
      end
    else
      redirect_to "/#login"
    end
  end

  def authenticate
    require 'net/imap'
    begin
      @failed = false
      @username = params[:username]
      @password = params[:password]
      flash[:imap_id] = @username

      imap = Net::IMAP.new("mail.nitt.edu")
      imap.login(@username, @password)

    rescue Net::IMAP::NoResponseError
      @failed = true
    rescue Exception => e
    end

    begin
      @user = User.find_by_email(@username)
    rescue
      @user = nil
    end

    respond_to do |format|
      format.html { 
        if @failed
          flash[:notice_type] = "alert-danger"
          redirect_to "/#login", notice: "Failed to authenticate"
        else
          if @user.nil? or not @user[:activated]
            redirect_to "/me"
          else
            session[:user_id] = @user.id
            redirect_to root_url
          end
          
        end
      }
    end
  end
  
  def signout
    session[:user_id] = nil
    redirect_to root_url
  end

end
