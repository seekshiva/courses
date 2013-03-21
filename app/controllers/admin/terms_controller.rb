class Admin::TermsController < Admin::BaseController
  # GET /terms
  # GET /terms.json
  def index
    @course = Course.find(params[:course_id])
    @terms = Term.find_all_by_course_id(params[:course_id])
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @terms }
    end
  end

  # GET /terms/1
  # GET /terms/1.json
  def show
    @course = Course.find(params[:course_id])
    @term = Term.find(params[:id])
    @new_faculty = TermFaculty.new
    @new_department = TermDepartment.new
    @departments_array = Department.all.collect do |dept|
      [dept.name, dept.id]
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @term }
    end
  end

  # GET /terms/new
  # GET /terms/new.json
  def new
    @course = Course.find(params[:course_id])
    @term = Term.new
    @legend = "New Term"
    @options = [[1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7],[8,8]]
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @term }
    end
  end

  # GET /terms/1/edit
  def edit
    @course = Course.find(params[:course_id])
    @term = Term.find(params[:id])
    @legend = "Editing Term"
    @options = [[1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7],[8,8]]

    respond_to do |format|
      format.html # edit.html.erb
      format.json { render json: @term }
    end
  end

  # POST /terms
  # POST /terms.json
  def create
    @course = Course.find(params[:course_id])
    @term = Term.new(params[:term])

    respond_to do |format|
      if @term.save
        format.html { redirect_to [:admin, @course, :terms], notice: 'Term was successfully created.' }
        format.json { render json: @term, status: :created, location: @term }
      else
        format.html { render action: "new" }
        format.json { render json: @term.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /terms/1
  # PUT /terms/1.json
  def update
    @course = Course.find(params[:course_id])
    @term = Term.find(params[:id])
    @term.course_id = params[:term_course_id]
    
    respond_to do |format|
      if @term.update_attributes(params[:term])
        format.html { redirect_to [:admin, @course, @term], notice: 'Term was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @term.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /terms/1
  # DELETE /terms/1.json
  def destroy
    @course = Course.find(params[:course_id])
    @term = Term.find(params[:id])
    @term.destroy

    respond_to do |format|
      format.html { redirect_to admin_course_terms_url(@course) }
      format.json { head :no_content }
    end
  end
end
