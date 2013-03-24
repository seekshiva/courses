class DepartmentsController < ApplicationController
  def index
    current_user
    @departments = Department.all

    respond_to do |format|
      format.json { render json: @departments  }
      format.html { render "home/dashboard" }
    end
  end

  def show
    respond_to do |format|
      format.html {
        current_user
        render "home/dashboard"
      }
      format.json {
        @department = Department.find(params[:id])
        @department["course_list"] = []

        arr, current_sem = [], nil
        @department.terms.each do |term|
          if term.this_year?
            if current_sem != term.semester 
              @department["course_list"] << {semester: "#{current_sem.ordinalize} semester", courses: arr} if not current_sem.nil?
              arr, current_sem = [], term.semester
            end
            term.course["instructors"] = term.faculties.collect do |faculty|
              "#{faculty.prefix} #{faculty.user.name}"
            end
            arr.push(term.course)
          end
        end
        @department["course_list"] << {semester: "#{current_sem.ordinalize} semester", courses: arr} if not current_sem.nil?
        
        render json: @department
      }
    end
  end
end
