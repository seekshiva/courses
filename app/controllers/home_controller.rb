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
  
  # GET /getting_started
  def getting_started
    if @user.nil? or not @user.activated?
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
    else
      redirect_to root_path
    end
  end

end
