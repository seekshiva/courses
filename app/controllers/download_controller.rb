class DownloadController < ApplicationController
  before_action :require_user

  def show
    begin
      @document = Document.find(params[:id])
    rescue
      render "home/dashboard"
    end
    if not @document.nil?
      send_file(@document.document.path, :type => @document.document_content_type, :filename => @document.document.original_filename , :disposition => 'inline')
    end
  end

end
