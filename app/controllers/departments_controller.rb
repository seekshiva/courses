class DepartmentsController < ApplicationController
  def index
    @departments = Department.all
    if session[:user_id]
      @user = User.find(session[:user_id])
    end

    respond_to do |format|
      format.json { render json: @departments  }
      format.html { render "home/dashboard" }
    end
  end

  def show
    @department = Department.find(params[:id])
    if session[:user_id]
      @user = User.find(session[:user_id])
    end

    @department["course_list"] = []

    arr, current_sem = [], nil
    @department.terms.each do |term|
      if term.this_year?
        if current_sem != term.semester 
          @department["course_list"] << {semester: current_sem, courses: arr} if not current_sem.nil?
          arr, current_sem = [], term.semester
        end
        arr.push(term.course)
      end
    end
    @department["course_list"] << {semester: current_sem, courses: arr} if not current_sem.nil?
    
    respond_to do |format|
      format.json { render json: @department  }
      format.html { render "home/dashboard" }
    end
  end
end
