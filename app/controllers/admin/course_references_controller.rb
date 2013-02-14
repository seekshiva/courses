class Admin::CourseReferencesController < Admin::BaseControllerController
  # GET /course_references
  # GET /course_references.json
  def index
    @course_references = CourseReference.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @course_references }
    end
  end

  # GET /course_references/1
  # GET /course_references/1.json
  def show
    @course_reference = CourseReference.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @course_reference }
    end
  end

  # GET /course_references/new
  # GET /course_references/new.json
  def new
    @legend = "New Course Reference"
    @course_reference = CourseReference.new
    @courses_array = Course.all.map do |course|
      ["#{course.subject_code} - #{course.name}", course.id]
    end

    @books_array = Book.all.map do |book|
      @authors = ""
      book.authors.each do |author|
        @authors += author.name + "; "
      end

      ["#{book.title} - #{@authors}", book.id]
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @course_reference }
    end
  end

  # GET /course_references/1/edit
  def edit
    @legend = "Edit Course Reference"
    @course_reference = CourseReference.find(params[:id])
    @courses_array = Course.all.map do |course|
      ["#{course.subject_code} - #{course.name}", course.id]
    end

    @books_array = Book.all.map do |book|
      @authors = ""
      book.authors.each do |author|
        @authors += author.name + "; "
      end

      ["#{book.title} - #{@authors}", book.id]
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @course_reference }
    end
  end

  # POST /course_references
  # POST /course_references.json
  def create
    @course_reference = CourseReference.new(params[:course_reference])

    respond_to do |format|
      if @course_reference.save
        format.html { redirect_to [:admin, @course_reference], notice: 'Course reference was successfully created.' }
        format.json { render json: @course_reference, status: :created, location: @course_reference }
      else
        format.html { render action: "new" }
        format.json { render json: @course_reference.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /course_references/1
  # PUT /course_references/1.json
  def update
    @course_reference = CourseReference.find(params[:id])

    respond_to do |format|
      if @course_reference.update_attributes(params[:course_reference])
        format.html { redirect_to [:admin, @course_reference], notice: 'Course reference was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @course_reference.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /course_references/1
  # DELETE /course_references/1.json
  def destroy
    @course_reference = CourseReference.find(params[:id])
    @course_reference.destroy

    respond_to do |format|
      format.html { redirect_to admin_course_references_url }
      format.json { head :no_content }
    end
  end
end
