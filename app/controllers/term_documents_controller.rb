class TermDocumentsController < ApplicationController
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
