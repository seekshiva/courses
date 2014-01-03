class SectionDocumentsController < ApplicationController

  before_action :require_user

  # GET /section_documents
  # GET /section_documents.json
  def index
    @section_documents = SectionDocument.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @section_documents }
    end
  end

  # GET /section_documents/1
  # GET /section_documents/1.json
  def show
    @section_document = SectionDocument.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @section_document }
    end
  end

  # GET /section_documents/new
  # GET /section_documents/new.json
  def new
    @section_document = SectionDocument.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @section_document }
    end
  end

  # GET /section_documents/1/edit
  def edit
    @section_document = SectionDocument.find(params[:id])
  end

  # POST /section_documents
  # POST /section_documents.json
  def create
    @section_document = SectionDocument.new(params[:section_document])

    respond_to do |format|
      if @section_document.save
        format.html { redirect_to @section_document, notice: 'Section document was successfully created.' }
        format.json { render json: @section_document, status: :created, location: @section_document }
      else
        format.html { render action: "new" }
        format.json { render json: @section_document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /section_documents/1
  # PUT /section_documents/1.json
  def update
    @section_document = SectionDocument.find(params[:id])

    respond_to do |format|
      if @section_document.update_attributes(params[:section_document])
        format.html { redirect_to @section_document, notice: 'Section document was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @section_document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /section_documents/1
  # DELETE /section_documents/1.json
  def destroy
    @section_document = SectionDocument.find(params[:id])
    @section_document.destroy

    respond_to do |format|
      format.html { redirect_to section_documents_url }
      format.json { head :no_content }
    end
  end
end
