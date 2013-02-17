class DepartmentsController < ApplicationController
  def index
    @departments = Department.all
    logger.debug "##################################### you are here"

    render json: @departments
    #respond_to do |format|
    #  format.json { render json: @departments  }
    #  format.html { render "home/dashboard" }
    #end
  end

  def show
    @department = Department.find(params[:id])
    @department["course_list"] = []

    temp = {}
    @department.courses.each do |course|
      sem = course.this_year.nil? ? "Not being offered this year" : "#{course.this_year.semester.ordinalize} semester"
      temp[sem] ||= []
      temp[sem].push(course)
    end
    
    for k,v in temp do 
      @department["course_list"].push({"semester" => k, "courses" => v})
    end
    
    respond_to do |format|
      format.json { render json: @department  }
      format.html { render "home/dashboard" }
    end
  end
end
