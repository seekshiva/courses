class TopicDocumentsController < ApplicationController
  # GET /topic_documents
  # GET /topic_documents.json
  def index
    @topic_documents = TopicDocument.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @topic_documents }
    end
  end

  # GET /topic_documents/1
  # GET /topic_documents/1.json
  def show
    @topic_document = TopicDocument.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @topic_document }
    end
  end

  # GET /topic_documents/new
  # GET /topic_documents/new.json
  def new
    @topic_document = TopicDocument.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @topic_document }
    end
  end

  # GET /topic_documents/1/edit
  def edit
    @topic_document = TopicDocument.find(params[:id])
  end

  # POST /topic_documents
  # POST /topic_documents.json
  def create
    @topic_document = TopicDocument.new(params[:topic_document])

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

  # PUT /topic_documents/1
  # PUT /topic_documents/1.json
  def update
    @topic_document = TopicDocument.find(params[:id])

    respond_to do |format|
      if @topic_document.update_attributes(params[:topic_document])
        format.html { redirect_to @topic_document, notice: 'Topic document was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
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
