class CourseListItemsController < ApplicationController
  # GET /course_list_items
  # GET /course_list_items.json
  def index
    # @course_list_items = CourseListItem.all
    @course_list_items = CourseListItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @course_list_items }
    end
  end

  # GET /course_list_items/1
  # GET /course_list_items/1.json
  def show
    @course_list_item = CourseListItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @course_list_item }
    end
  end

  # GET /course_list_items/new
  # GET /course_list_items/new.json
  def new
    @course_list_item = CourseListItem.new
    @departments_array = Department.all.map do |department|
      ["(#{department.short}) #{department.name}", department.id]
    end
    @courses_array = Course.all.map do |course|
      ["#{course.subject_code} - #{course.name}", course.id]
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @course_list_item }
    end
  end

  # GET /course_list_items/1/edit
  def edit
    @course_list_item = CourseListItem.find(params[:id])
    @departments_array = Department.all.map do |department|
      ["(#{department.short}) #{department.name}", department.id]
    end
    @courses_array = Course.all.map do |course|
      ["#{course.subject_code} - #{course.name}", course.id]
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @course_list_item }
    end
  end

  # POST /course_list_items
  # POST /course_list_items.json
  def create
    @course_list_item = CourseListItem.new(params[:course_list_item])
    logger.debug "################################################"
    logger.debug params
    logger.debug params[:course_list_item]
    logger.debug "################################################"

    respond_to do |format|
      if @course_list_item.save
        format.html { redirect_to @course_list_item, notice: 'Course list item was successfully created.' }
        format.json { render json: @course_list_item, status: :created, location: @course_list_item }
      else
        format.html { render action: "new" }
        format.json { render json: @course_list_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /course_list_items/1
  # PUT /course_list_items/1.json
  def update
    @course_list_item = CourseListItem.find(params[:id])

    respond_to do |format|
      if @course_list_item.update_attributes(params[:course_list_item])
        format.html { redirect_to @course_list_item, notice: 'Course list item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @course_list_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /course_list_items/1
  # DELETE /course_list_items/1.json
  def destroy
    @course_list_item = CourseListItem.find(params[:id])
    @course_list_item.destroy

    respond_to do |format|
      format.html { redirect_to course_list_items_url }
      format.json { head :no_content }
    end
  end
end
