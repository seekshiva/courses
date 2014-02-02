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
        file = File.basename(@document.document.path)
        if Rails.env == "production"
          path = "/home/cap/apps/courses/shared/public/system/files/"+file
        else
          path = @document.document.path
        end
        send_file(path, :filename => @document.document.original_filename, :type => @document.document_content_type)
      end
    end
  end

end
