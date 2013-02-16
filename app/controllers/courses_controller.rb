class CoursesController < ApplicationController
  def index
    @courses = Course.all

    respond_to do |format|
      format.json { render json: @courses  }
      format.html { render "home/dashboard" }
    end
  end

  def show
    @course = Course.find(params[:id])

    respond_to do |format|
      format.json { render json: @course  }
      format.html { render "home/dashboard" }
    end
  end
end
