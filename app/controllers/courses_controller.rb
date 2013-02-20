class CoursesController < ApplicationController
  def show
    @course = Course.find(params[:id])
    @course["departments"] = @course.departments
    if @course.current_term
      @course["current"] = {
        semester: @course.current_term.semester.ordinalize,
        year:     "#{@course.current_term.academic_year}-#{@course.current_term.academic_year+1}"
      } 
    end

    respond_to do |format|
      format.json { render json: @course  }
      format.html { render "home/dashboard" }
    end
  end
end
