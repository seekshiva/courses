class TopicDocumentsController < ApplicationController

  before_action :require_user

  # POST /topic_documents
  # POST /topic_documents.json
  def create
    data = {
      document_id: params[:topic_document][:note_id],
      topic_id: params[:topic_document][:topic_id]
    }

    @topic_document = TopicDocument.new(data)
    respond_to do |format|
      if @topic_document.save
        format.html { redirect_to @topic_document, notice: 'Topic document was successfully created.' }
        format.json { render json: @topic_document, status: :created, location: @topic_document }
      else
        format.html { render action: "new" }
        format.json { render json: @topic_document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topic_documents/1
  # DELETE /topic_documents/1.json
  def destroy
    @topic_document = TopicDocument.find(params[:id])
    @topic_document.destroy

    respond_to do |format|
      format.html { redirect_to topic_documents_url }
      format.json { head :no_content }
    end
  end
end
