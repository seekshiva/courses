class TopicReferencesController < ApplicationController

  before_action :require_user

  # POST /topic_references
  # POST /topic_references.json
  def create
    fields = params[:topic_reference]
    fields = {
      term_reference_id:    fields[:term_reference_id],
      topic_id:             fields[:topic_id],
      indices:              fields[:indices]
    }
    @topic_reference = Reference.new(fields)

    respond_to do |format|
      if @topic_reference.save
        format.html { redirect_to @topic_reference, notice: 'Topic reference was successfully created.' }
        format.json { render json: @topic_reference, status: :created}
      else
        format.html { render action: "new" }
        format.json { render json: @topic_reference.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /topic_references/1
  # PUT /topic_references/1.json
  def update
    fields = params[:topic_reference]
    fields = {
      term_reference_id:    fields[:term_reference_id],
      topic_id:             fields[:topic_id],
      indices:              fields[:indices]
    }
    @topic_reference = Reference.find(params[:id])

    respond_to do |format|
      if @topic_reference.update_attributes(fields)
        format.html { redirect_to @topic_reference, notice: 'Topic reference was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @topic_reference.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topic_references/1
  # DELETE /topic_references/1.json
  def destroy
    @topic_reference = Reference.find(params[:id])
    @topic_reference.destroy

    respond_to do |format|
      format.html {  }
      format.json { head :no_content }
    end
  end
end
