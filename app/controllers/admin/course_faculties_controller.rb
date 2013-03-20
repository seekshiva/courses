class Admin::CourseFacultiesController < Admin::BaseController
  # GET /course_faculties
  # GET /course_faculties.json
  def index
    @course_faculties = CourseFaculty.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @course_faculties }
    end
  end

  # GET /course_faculties/1
  # GET /course_faculties/1.json
  def show
    @course_faculty = CourseFaculty.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @course_faculty }
    end
  end

  # GET /course_faculties/new
  # GET /course_faculties/new.json
  def new
    @course_faculty = CourseFaculty.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @course_faculty }
    end
  end

  # GET /course_faculties/1/edit
  def edit
    @course_faculty = CourseFaculty.find(params[:id])
  end

  # POST /course_faculties
  # POST /course_faculties.json
  def create
    @course_faculty = CourseFaculty.new(params[:course_faculty])
    @course = @course_faculty.course

    respond_to do |format|
      if @course_faculty.save
        format.html { redirect_to [:admin, @course], notice: 'Course faculty was successfully created.' }
        format.json { render json: @course_faculty, status: :created, location: @course_faculty }
      else
        format.html { render action: "new" }
        format.json { render json: @course_faculty.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /course_faculties/1
  # PUT /course_faculties/1.json
  def update
    @course_faculty = CourseFaculty.find(params[:id])
    @course = @course_faculty.course

    respond_to do |format|
      if @course_faculty.update_attributes(params[:course_faculty])
        format.html { redirect_to [:admin, @course], notice: 'Course faculty was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @course_faculty.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /course_faculties/1
  # DELETE /course_faculties/1.json
  def destroy
    @course_faculty = CourseFaculty.find(params[:id])
    @course = @course_faculty.course
    @course_faculty.destroy

    respond_to do |format|
      format.html { redirect_to [:admin, @course] }
      format.json { head :no_content }
    end
  end
end
