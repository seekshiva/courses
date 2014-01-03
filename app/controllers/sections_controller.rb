class SectionsController < ApplicationController

  before_action :require_user

  # POST /sections
  # POST /sections.json
  def create
    section = Section.new({ term_id: params[:section][:term_id], title: params[:section][:title] })

    respond_to do |format|
      if section.save
        ret = {
          id:               section.id,
          title:            section.title,
          short_title:      section.title.length > 30 ? "#{section.title[0,28]}..." : section.title,
          show_short_title: section.title.length > 30,
          topics:           Array.new
        }
        format.html #{ redirect_to @section, notice: 'Section was successfully created.' }
        format.json { render json: ret, status: :created, location: section }
      else
        format.html #{ render action: "new" }
        format.json { render json: section.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sections/1
  # PUT /sections/1.json
  def update
    @section = Section.find(params[:id])

    respond_to do |format|
      if @section.update_attributes(params[:section].except(:id, :topics, :classes, :short_title, :show_short_title))
        format.html #{ redirect_to @section, notice: 'Section was successfully updated.' }
        format.json { head :no_content }
      else
        format.html #{ render action: "edit" }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sections/1
  # DELETE /sections/1.json
  def destroy
    @section = Section.find(params[:id])
    @section.destroy

    respond_to do |format|
      format.html #{ redirect_to sections_url }
      format.json { head :no_content }
    end
  end
end
