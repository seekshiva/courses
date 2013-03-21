class DepartmentsController < ApplicationController
  def index
    @departments = Department.all

    respond_to do |format|
      format.json { render json: @departments  }
      format.html { render "home/dashboard" }
    end
  end

  def show
    @department = Department.find(params[:id])
    @department["course_list"] = []

    temp = []
    @department.courses.each do |course|
      sem = course.this_year.nil? ? 0 : course.this_year.semester
      course["instructor"] = course.faculties.collect do |faculty|
        "#{faculty.prefix}#{faculty.user.name}"
      end
      temp[sem] ||= []
      temp[sem] << course
    end
    
    temp.each_with_index do |c_list, sem|
      unless c_list.nil?
        semester = sem==0 ? "Not being offered this year" : "#{sem.ordinalize} semester"
        @department["course_list"] << {"semester" => semester, "courses" => c_list}
      end
    end
    
    respond_to do |format|
      format.json { render json: @department  }
      format.html { render "home/dashboard" }
    end
  end
end
