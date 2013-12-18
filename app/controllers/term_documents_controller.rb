class TermDocumentsController < ApplicationController
  # GET /term_documents
  # GET /term_documents.json
  def index
    @term_documents = TermDocument.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @term_documents }
    end
  end

  # GET /term_documents/1
  # GET /term_documents/1.json
  def show
    @term_document = TermDocument.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @term_document }
    end
  end

  # GET /term_documents/new
  # GET /term_documents/new.json
  def new
    @term_document = TermDocument.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @term_document }
    end
  end

  # GET /term_documents/1/edit
  def edit
    @term_document = TermDocument.find(params[:id])
  end

  # POST /term_documents
  # POST /term_documents.json
  def create
    @term_document = TermDocument.new(params[:term_document])

    respond_to do |format|
      if @term_document.save
        format.html { redirect_to @term_document, notice: 'Term document was successfully created.' }
        format.json { render json: @term_document, status: :created, location: @term_document }
      else
        format.html { render action: "new" }
        format.json { render json: @term_document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /term_documents/1
  # PUT /term_documents/1.json
  def update
    @term_document = TermDocument.find(params[:id])

    respond_to do |format|
      if @term_document.update_attributes(params[:term_document])
        format.html { redirect_to @term_document, notice: 'Term document was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @term_document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /term_documents/1
  # DELETE /term_documents/1.json
  def destroy
    @term_document = TermDocument.find(params[:id])
    @term_document.destroy

    respond_to do |format|
      format.html { redirect_to term_documents_url }
      format.json { head :no_content }
    end
  end
end
