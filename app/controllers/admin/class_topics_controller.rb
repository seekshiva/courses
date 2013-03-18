class Admin::ClassTopicsController < Admin::BaseController
  # GET /class_topics
  # GET /class_topics.json
  def index
    @course = Course.find(params[:course_id])
    @class_topics = ClassTopic.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @class_topics }
    end
  end

  # GET /class_topics/1
  # GET /class_topics/1.json
  def show
    @course = Course.find(params[:course_id])
    @class_topic = ClassTopic.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @class_topic }
    end
  end

  # GET /class_topics/new
  # GET /class_topics/new.json
  def new
    @course = Course.find(params[:course_id])
    

    ClassTopic.new
    @class_topic = ClassTopic.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @class_topic }
    end
  end

  # GET /class_topics/1/edit
  def edit
    @course = Course.find(params[:course_id])
    @class_topic = ClassTopic.find(params[:id])
  end

  # POST /class_topics
  # POST /class_topics.json
  def create
    @course = Course.find(params[:course_id])
    @class_topic = ClassTopic.new(params[:class_topic])

    respond_to do |format|
      if @class_topic.save
        format.html { redirect_to [:admin, @course, @class_topic], notice: 'Class topic was successfully created.' }
        format.json { render json: @class_topic, status: :created, location: @class_topic }
      else
        format.html { render action: "new" }
        format.json { render json: @class_topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /class_topics/1
  # PUT /class_topics/1.json
  def update
    @course = Course.find(params[:course_id])
    @class_topic = ClassTopic.find(params[:id])

    respond_to do |format|
      if @class_topic.update_attributes(params[:class_topic])
        format.html { redirect_to [:admin, @course, @class_topic], notice: 'Class topic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @class_topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /class_topics/1
  # DELETE /class_topics/1.json
  def destroy
    @course = Course.find(params[:course_id])
    @class_topic = ClassTopic.find(params[:id])
    @class_topic.destroy

    respond_to do |format|
      format.html { redirect_to [:admin, @course, :class_topics] }
      format.json { head :no_content }
    end
  end
end
