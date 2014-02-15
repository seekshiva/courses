class Admin::DocumentsController < Admin::BaseController
  # GET /admin/documents
  # GET /admin/documents.json
  def index
    @page_no = params[:page] || 1
    if params[:search]
      @documents = Document.where("id = ? or document_file_name like ? or document_content_type like ?", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%").paginate(:page => @page_no, :per_page => 20)
    else
      @documents = Document.paginate(:page => @page_no, :per_page => 20)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @documents }
    end
  end

  # DELETE /admin/documents/1
  # DELETE /admin/documents/1.json
  def destroy
    @document = Document.find(params[:id])
    @document.destroy
    
    respond_to do |format|
      format.html { redirect_to admin_documents_url, notice: 'Document was successfully deleted.' }
      format.json { head :no_content }
    end
  end

end
