class Admin::TermDepartmentsController < Admin::BaseController
  # GET /term_departments
  # GET /term_departments.json
  def index
    @course = Course.find(params[:course_id])
    @terms_array = @course.terms.collect do |term|
      term.id
    end
    @term_departments = TermDepartment.find_all_by_term_id(@terms_array)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @term_departments }
    end
  end

  # GET /term_departments/1
  # GET /term_departments/1.json
  def show
    @course = Course.find(params[:course_id])
    @term_department = TermDepartment.find(params[:id])
    @term = @term_department.term

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @term_department }
    end
  end

  # GET /term_departments/new
  # GET /term_departments/new.json
  def new
    @course = Course.find(params[:course_id])
    @term_department = TermDepartment.new
    @legend = "New term_department"
    @terms_array = @course.terms.collect do |term|
      ["##{term.id} #{term.course.subject_code} #{term.year} - #{term.semester.ordinalize} semester", term.id]
    end
    @departments_array = Department.all.collect do |department|
      [department.name, department.id]
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @term_department }
    end
  end

  # GET /term_departments/1/edit
  def edit
    @course = Course.find(params[:course_id])
    @term_department = TermDepartment.find(params[:id])
    @legend = "Edit term_department"

    respond_to do |format|
      format.html # edit.html.erb
      format.json { render json: @term_department }
    end
  end

  # POST /term_departments
  # POST /term_departments.json
  def create
    @course = Course.find(params[:course_id])
    @term_department = TermDepartment.new(params[:term_department])

    respond_to do |format|
      if @term_department.save
        format.html { redirect_to [:admin, @course], notice: 'Term department was successfully created.' }
        format.json { render json: @term_department, status: :created, location: @term_department }
      else
        flash = flash
        format.html { redirect_to [:admin, @course] }
        format.json { render json: @term_department.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /term_departments/1
  # PUT /term_departments/1.json
  def update
    @course = Course.find(params[:course_id])
    @term_department = TermDepartment.find(params[:id])

    respond_to do |format|
      if @term_department.update_attributes(params[:term_department])
        format.html { redirect_to [:admin, @course, @term_department], notice: 'Term department was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @term_department.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /term_departments/1
  # DELETE /term_departments/1.json
  def destroy
    @course = Course.find(params[:course_id])
    @term_department = TermDepartment.find(params[:id])
    @term_department.destroy

    respond_to do |format|
      format.html { redirect_to [:admin, @course] }
      format.json { head :no_content }
    end
  end
end
