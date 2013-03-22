class TopicsController < ApplicationController
  # GET /topics
  # GET /topics.json
  def index
    respond_to do |format|
      format.html {
        render "home/dashboard"
      }

      format.json {
        @course = Course.find(params[:course_id])
        @topics = Topic.find_all_by_course_id(@course.id)
        @topics.each do |topic|
          topic["reference"] = topic.references.collect do |ref|
            {:book => ref.course_reference.book.title, :sections => ref.sections }
          end
          topic["classes"] = topic.classrooms.collect do |cl|
            {id: cl.id, date: cl.date.strftime("%D"), time: cl.time, venue: cl.room }
          end
        end
    
        render json: @topics
      }
    end

  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    @course = Course.find(params[:course_id])
    @topic = @course.topics.find(params[:id])
    @ref_books = @course.books
    @back = true

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @topic }
    end
  end

  # GET /topics/new
  # GET /topics/new.json
  def new
    @course = Course.find(params[:course_id])
    @topic = @course.topics.build
    @legend = "New topic"

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @topic }
    end
  end

  # GET /topics/1/edit
  def edit
    @legend = "Edit Topic"
    @course = Course.find(params[:course_id])
    @topic = @course.topics.find(params[:id])
    @ref_books = @course.books

    respond_to do |format|
      format.html # edit.html.erb
      format.json { render json: @topic }
    end
  end

  # POST /topics
  # POST /topics.json
  def create
    @course = Course.find(params[:course_id])
    @topic = @course.topics.build(params[:topic])

    respond_to do |format|
      if @topic.save
        format.html { redirect_to [:admin, @course], notice: 'Topic was successfully created.' }
        format.json { render json: @topic, status: :created, location: @topic }
      else
        format.html { render action: "new" }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /topics/1
  # PUT /topics/1.json
  def update
    @course = Course.find(params[:course_id])
    @topic = Topic.find(params[:id])

    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        format.html { redirect_to [:admin, @course], notice: 'Topic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to admin_topics_url }
      format.json { head :no_content }
    end
  end
end
