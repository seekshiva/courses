class TopicsController < ApplicationController
  # POST /topics
  # POST /topics.json
  def create
    topic = Topic.new(params[:topic])

    respond_to do |format|
      if topic.save
        ret = {
          id:     topic.id,
          title:            topic.title,
          description:      topic.description,
          ct_status:        topic.ct_status,
          reference:       Array.new(),
          classes:          Array.new()
        }
        format.html #{ redirect_to @topic, notice: 'Topic was successfully created.' }
        format.json { render json: ret, status: :created, location: topic }
      else
        format.html #{ render action: "new" }
        format.json { render json: topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /topics/1
  # PUT /topics/1.json
  def update
    @topic = Topic.find(params[:id])

    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        format.html #{ redirect_to @topic, notice: 'Topic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html #{ render action: "edit" }
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
      format.html #{ redirect_to topics_url }
      format.json { head :no_content }
    end
  end
end
