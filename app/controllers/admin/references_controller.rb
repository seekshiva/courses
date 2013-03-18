class Admin::ReferencesController < Admin::BaseController
  # GET /references
  # GET /references.json
  def index
    @references = Reference.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @references }
    end
  end

  # GET /references/1
  # GET /references/1.json
  def show
    @reference = Reference.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reference }
    end
  end

  # GET /references/new
  # GET /references/new.json
  def new
    @new = true
    @legend = "New Reference"
    @reference = Reference.new
    
    @course_reference_array = CourseReference.all.map do |cr|
      ["#{cr.course.subject_code} - #{cr.book.title}", cr.id]
    end
    @topics_array = Topic.all.map do |topic|
      ["#{topic.course.subject_code} - #{topic.title}", topic.id]
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reference }
    end
  end

  # GET /references/1/edit
  def edit
    @legend = "Edit reference"
    @reference = Reference.find(params[:id])

    @course_reference_array = CourseReference.all.map do |cr|
      ["#{cr.course.subject_code} - #{cr.book.title}", cr.id]
    end
    @topics_array = Topic.all.map do |topic|
      ["#{topic.course.subject_code} - #{topic.title}", topic.id]
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reference }
    end
  end

  # POST /references
  # POST /references.json
  def create
    @reference = Reference.new(params[:reference])

    respond_to do |format|
      if @reference.save
        format.html { redirect_to [:admin, @reference], notice: 'Reference was successfully created.' }
        format.json { render json: @reference, status: :created, location: @reference }
      else
        format.html { render action: "new" }
        format.json { render json: @reference.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /references/1
  # PUT /references/1.json
  def update
    @reference = Reference.find(params[:id])

    respond_to do |format|
      if @reference.update_attributes(params[:reference])
        format.html { redirect_to [:admin, @reference], notice: 'Reference was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reference.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /references/1
  # DELETE /references/1.json
  def destroy
    @reference = Reference.find(params[:id])
    @reference.destroy

    respond_to do |format|
      format.html { redirect_to admin_references_url }
      format.json { head :no_content }
    end
  end
end
