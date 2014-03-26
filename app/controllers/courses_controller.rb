class CoursesController < ApplicationController
  def show
    respond_to do |format|
      format.html { render "home/dashboard" }
      
      format.json do
        course = Course.find(params[:id])
        render json: course.as_json(include: {all: true})
      end
    end
  end
end
