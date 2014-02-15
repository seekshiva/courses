class HomeController < ApplicationController

  respond_to :html

  # GET /
  # GET /login
  # GET /:slug
  # GET /:slug/*route
  def index
    respond_to do |format|
      format.html { render "home/dashboard" }
    end
  end
  
  # GET /me
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
        
        if @user.student?
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
        redirect_to login_path
      end
    end
  end

  # POST /authenticate
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
            if (!@user.current_sign_in_at.nil? && @user.current_sign_in_at - Time.now() > 1.week) || @user.doc_access_token.nil?
              access_token = Digest::MD5.hexdigest(@user.email+Time.now().to_s)
            else
              access_token = @user.doc_access_token
            end
            @user.update_attributes(
              { 
                :doc_access_token     => access_token,
                :sign_in_count        => @user.sign_in_count+1,
                :last_sign_in_at      => @user.current_sign_in_at,
                :current_sign_in_at   => Time.now(),
                :last_sign_in_ip      => @user.current_sign_in_ip,
                :current_sign_in_ip   => request.remote_ip
              })
            flash[:notice_type] = 'alert-success'
            flash[:notice] = "You have successfully logged in!"
            redirect_to @redirect_url || root_url
          end
          
        end
      }
    end
  end
  
  def signout
    if not session[:admin_user_id].nil?
      session[:user_id] = session[:admin_user_id]
      session[:admin_user_id] = nil
      redirect_to "/admin"
    else
      @user.update_attributes({ :doc_access_token => nil })      
      session[:user_id] = nil
      flash[:notice_type] = 'alert-success'
      redirect_to root_url, notice: "You have successfully logged out."
    end
  end

end
