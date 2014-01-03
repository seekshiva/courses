class ClassroomsController < Admin::BaseController

  before_action :require_user

  # GET /classrooms
  # GET /classrooms.json
  def index
    @course = Course.find(params[:course_id])
    @classes = Classroom.where("term_id IN (" + @course.this_year.collect do |term|
                                 term.id
                               end.join(",") + ")").collect do |cl|
      ret = {date: "#{cl.date.strftime('%-d').to_i.ordinalize} #{cl.date.strftime('%b')}", time: cl.time, room: cl.room, term_id: cl.term_id }
      ret["topics"] = cl.topics.collect do |topic|
        { id: topic.id, ct_status: topic.ct_status, title: topic.title }
      end
      
      ret
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @classes }
    end
  end

  # GET /classrooms/1
  # GET /classrooms/1.json
  def show
    @course = Course.find(params[:course_id])
    @class = Classroom.find(params[:id])

    logger.debug @class.topics

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @classroom }
    end
  end

  # GET /classrooms/new
  # GET /classrooms/new.json
  def new
    @course = Course.find(params[:course_id])
    @legend = "New Class"
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
    @legend = "Edit Class Details"
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
    @classroom.class_topics.delete_all
    params[:class_topics].each do |topic|
      @ct = @classroom.class_topics.build(:topic_id => topic)
      @ct.save
    end

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
