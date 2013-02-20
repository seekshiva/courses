class Admin::ClassroomsController < Admin::BaseControllerController
  # GET /classrooms
  # GET /classrooms.json
  def index
    @course = Course.find(params[:course_id])
    @classrooms = Classroom.find_all_by_term_id(@course.current_term.id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @classrooms }
    end
  end

  # GET /classrooms/1
  # GET /classrooms/1.json
  def show
    @course = Course.find(params[:course_id])
    @classroom = Classroom.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @classroom }
    end
  end

  # GET /classrooms/new
  # GET /classrooms/new.json
  def new
    @course = Course.find(params[:course_id])
    @legend = "New Classroom"
    @classroom = Classroom.new
    @options = [["08:30 AM", "8:30 AM"], ["09:20 AM", "9:20 AM"], ["10:30 AM", "10:30 AM"], ["11:20 AM", "11:20 AM"], ["01:30 PM", "1:30 PM"], ["02:20 PM", "2:20 PM"], ["03:10 PM", "3:10 PM"], ["04:00 PM", "4 PM"]]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @classroom }
    end
  end

  # GET /classrooms/1/edit
  def edit
    @course = Course.find(params[:course_id])
    @legend = "Edit Classroom"
    @classroom = Classroom.find(params[:id])
    @options = [["08:30 AM", "8:30 AM"], ["09:20 AM", "9:20 AM"], ["10:30 AM", "10:30 AM"], ["11:20 AM", "11:20 AM"], ["01:30 PM", "1:30 PM"], ["02:20 PM", "2:20 PM"], ["03:10 PM", "3:10 PM"], ["04:00 PM", "4 PM"]]
    @opt_default = @classroom.time

    respond_to do |format|
      format.html # edit.html.erb
      format.json { render json: @classroom }
    end
  end

  # POST /classrooms
  # POST /classrooms.json
  def create
    @course = Course.find(params[:course_id])
    @classroom = Classroom.new(params[:classroom])

    respond_to do |format|
      if @classroom.save
        format.html { redirect_to [:admin, @course, @classroom], notice: 'Classroom was successfully created.' }
        format.json { render json: @classroom, status: :created, location: @classroom }
      else
        format.html { render action: "new" }
        format.json { render json: @classroom.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /classrooms/1
  # PUT /classrooms/1.json
  def update
    @course = Course.find(params[:course_id])
    @classroom = Classroom.find(params[:id])

    respond_to do |format|
      if @classroom.update_attributes(params[:classroom])
        format.html { redirect_to [:admin, @course, @classroom], notice: 'Classroom was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @classroom.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /classrooms/1
  # DELETE /classrooms/1.json
  def destroy
    @course = Course.find(params[:course_id])
    @classroom = Classroom.find(params[:id])
    @classroom.destroy

    respond_to do |format|
      format.html { redirect_to admin_course_classrooms_url(@course) }
      format.json { head :no_content }
    end
  end
end
