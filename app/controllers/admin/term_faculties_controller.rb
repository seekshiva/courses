class Admin::TermFacultiesController < Admin::BaseController
  # GET /courses/:course_id/term_faculties
  # GET /courses/:course_id/term_faculties.json
  def index
    @term_faculties = TermFaculty.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @term_faculties }
    end
  end

  # GET /courses/:course_id/term_faculties/1
  # GET /courses/:course_id/term_faculties/1.json
  def show
    @term_faculty = TermFaculty.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @term_faculty }
    end
  end

  # GET /courses/:course_id/temr_faculties/new
  # GET /courses/:course_id/term_faculties/new.json
  def new
    @term_faculty = TermFaculty.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @term_faculty }
    end
  end

  # GET /courses/:course_id/term_faculties/1/edit
  def edit
    @term_faculty = TermFaculty.find(params[:id])
  end

  # POST /courses/:course_id/term_faculties
  # POST /courses/:course_id/term_faculties.json
  def create
    @term_faculty = TermFaculty.new
    @term_faculty.term_id = params[:term_faculty][:term_id].to_i
    @term_faculty.faculty_id = Faculty.find_by_user_id(User.find_by_email(params[:term_faculty][:faculty])).id

    @course = @term_faculty.course

    respond_to do |format|
      if @term_faculty.save
        format.html { redirect_to [:admin, @course], notice: 'Course faculty was successfully created.' }
        format.json { render json: @term_faculty, status: :created, location: @term_faculty }
      else
        format.html { render action: "new" }
        format.json { render json: @term_faculty.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /courses/:course_id/term_faculties/1
  # PUT /courses/:course_id/term_faculties/1.json
  def update
    @term_faculty = TermFaculty.find(params[:id])
    @course = @term_faculty.course

    respond_to do |format|
      if @term_faculty.update_attributes(params[:term_faculty])
        format.html { redirect_to [:admin, @course], notice: 'Course faculty was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @term_faculty.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/:course_id/term_faculties/1
  # DELETE /courses/:course_id/term_faculties/1.json
  def destroy
    @term_faculty = TermFaculty.find(params[:id])
    @course = @term_faculty.course
    @term_faculty.destroy

    respond_to do |format|
      format.html { redirect_to [:admin, @course] }
      format.json { head :no_content }
    end
  end
end
