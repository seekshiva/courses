class UploadController < ApplicationController

  before_action :require_user

	# GET /upload
  # GET /upload.json
  def index  
    respond_to do |format|
      format.html { render "home/dashboard" }
      format.json { render json: { message: "UploadController only responds to POST"} }
    end
  end

  # POST /upload/:tab
  # POST /upload/:tab.json
  def create
    tag = params[:tab]

    if !@user.id
      render :json => {:msg => "Upload Failed", :error => "User not logged in"}
    end

    if tag == "book_cover"
      # Process book cover
      data = Hash.new
      data[:cover] = params[:Filedata]
      data[:cover].content_type = MIME::Types.type_for(params[:Filedata].original_filename).first.content_type
      data[:uploaded_by] = @user.id

      @book_cover = BookCover.new(data)
      if @book_cover.save()
        render :json => {:msg => "Upload Success", :status => "0", :id => @book_cover.id, :url => @book_cover.cover.url(:thumb) }
      else
        render :json => {:msg => "Upload Failed", :status => "1", :error => @book_cover.errors}
      end
    elsif tag == "avatar"
      # Process avatar
      data = Hash.new
      data[:pic] = params[:Filedata]
      data[:pic].content_type = MIME::Types.type_for(params[:Filedata].original_filename).first.content_type

      @avatar = Avatar.new(data)
      if @avatar.save
        render :json => {:msg => "Upload Success", :status => "0", :id => @avatar.id, :url => @avatar.pic.url(:large) }
      else 
        render :json => {:msg => "Upload Failed", :status => "1", :error => @avatar.errors}
      end
    elsif tag == "document"
      # Save file
      data = Hash.new
      data[:document] = params[:Filedata]
      data[:document].content_type = MIME::Types.type_for(params[:Filedata].original_filename).first.content_type
      data[:uploaded_by] = @user.id

      @file = Document.new(data)
      if @file.save
        render :json => {:msg => "Upload Success", :status => "0", :id => @file.id, :url => @file.document.url, :name => @file.document.original_filename }
      else
        render :json => {:msg => "Upload Failed", :status => "1", :error => @file.errors}
      end
    end
  end

end
