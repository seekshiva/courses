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

    respond_to do |format|
      format.json { render json: @department  }
      format.html { render "home/dashboard" }
    end
  end
end
