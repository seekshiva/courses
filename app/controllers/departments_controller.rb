class DepartmentsController < ApplicationController
  def index
    respond_to do |format|
      format.html { render "home/dashboard" }
      format.json { render json: Department.all.collect { |dept| dept.as_json } }
    end
  end

  def show
    respond_to do |format|
      format.html { render "home/dashboard" }
	  
      format.json {
        dept = get_dept params[:id]

        if dept.nil?
          render json: { status: "Page Not Found" }, status: 404
        else
          render json: dept.as_json(include: :course_listing)
        end
      }
    end
  end

  private

  def get_dept(id)
    if id.match(/^[[:alpha:]]+$/)
      dept = Department.find_by(:short => params[:id])
    else
      dept = Department.find(params[:id])
    end
  end

end
