class HomeController < ApplicationController
  def index
    respond_to do |format|
      format.html { render "home/dashboard" }
    end
  end
  
  def me
    if not @user.nil?
      render "home/dashboard"
    else
      @user = User.find_by email: flash[:imap_id]
      if @user.nil?
        @user = User.new
      end

      @departments_array = Department.all.map do |department|
        ["#{department.name}", department.id]
      end

      if flash[:imap_id]
        @user[:email] = flash[:imap_id]
        
        if @user.is_student?
          begin
            @user.department_id = Department.find_by(rollno_prefix: @user[:email][0..3]).id
          rescue
            @user.department_id = 0
          end
          
          @course_list = []
          Course.all.each do |course|
            course.current_term.each do |term|
              if (term.semester+1)/2 == @user.nth_year
                term.departments.each do |dept|
                  if dept.id == @user.department_id 
                    @course_list << course
                  end
                end
              end
            end
          end
          # This can be done in sql 
          # @course_list = Course.all.current_term.where("semester = {@user.nth_year*2} OR semester = {(@user.nth_year*2)-1} )
          # Please check before uncommenting the above line
        else 
          @user.department_id = 0
        end
      else
        redirect_to "/login"
      end
    end
  end

  def authenticate
    require 'net/imap'
    begin
      @failed = false
      @username = params[:username]
      @password = params[:password]
      @redirect_url = params[:redirect_url]
      flash[:imap_id] = @username

      imap = Net::IMAP.new("mail.nitt.edu")
      imap.login(@username, @password)

    rescue Net::IMAP::NoResponseError
      @failed = true
    rescue Net::IMAP::BadResponseError
      @failed = true
    rescue Exception => e
      # uncomment the following line to login as anyone when not connected to the internet
      @failed = true
    end

    begin
      @user = User.find_by email: @username
    rescue
      @user = nil
    end

    respond_to do |format|
      format.html { 
        if @failed
          flash[:notice_type] = "alert-danger"
          redirect_to "/login", notice: "Username or Password is Invalid"
        else
          if @user.nil? or not @user.account_activated?
            redirect_to "/me"
          else
            session[:user_id] = @user.id
            redirect_to @redirect_url || root_url
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
