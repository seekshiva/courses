class DownloadController < ApplicationController

  def show
    if @user.nil?
      if not params[:access_token].nil?
        @user = User.where({doc_access_token: params[:access_token]}).first()
      end
    end

    if @user.nil?
      respond_to do |format|
        format.html { render "home/dashboard" }
        format.json { render nothing: true , :status => 401 }
      end
    else
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

end
