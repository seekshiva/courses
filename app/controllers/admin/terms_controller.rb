class Admin::TermsController < ApplicationController
  # GET /terms
  # GET /terms.json
  def index
    @terms = Term.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @terms }
    end
  end

  # GET /terms/1
  # GET /terms/1.json
  def show
    @term = Term.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @term }
    end
  end

  # GET /terms/new
  # GET /terms/new.json
  def new
    @courses_array = Course.all.map do |course|
      ["#{course.subject_code} - #{course.name}", course.id]
    end
    @term = Term.new
    @legend = "New Term"
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @term }
    end
  end

  # GET /terms/1/edit
  def edit
    @courses_array = Course.all.map do |course|
      ["#{course.subject_code} - #{course.name}", course.id]
    end
    @term = Term.find(params[:id])
    @legend = "Editing Term"

    respond_to do |format|
      format.html # edit.html.erb
      format.json { render json: @term }
    end
  end

  # POST /terms
  # POST /terms.json
  def create
    @term = Term.new(params[:term])
    @term.course_id = params[:term_course_id]

    respond_to do |format|
      if @term.save
        format.html { redirect_to [:admin, @term], notice: 'Term was successfully created.' }
        format.json { render json: @term, status: :created, location: @term }
      else
        format.html { render action: "new" }
        format.json { render json: @term.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /terms/1
  # PUT /terms/1.json
  def update
    @term = Term.find(params[:id])
    @term.course_id = params[:term_course_id]
    
    respond_to do |format|
      if @term.update_attributes(params[:term])
        format.html { redirect_to [:admin, @term], notice: 'Term was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @term.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /terms/1
  # DELETE /terms/1.json
  def destroy
    @term = Term.find(params[:id])
    @term.destroy

    respond_to do |format|
      format.html { redirect_to admin_terms_url }
      format.json { head :no_content }
    end
  end
end
