class Admin::FacultiesController < Admin::BaseController
  # GET /faculties
  # GET /faculties.json
  def index
    @page_no = params[:page] || 1
    @faculties = Faculty.paginate(:page => @page_no, :per_page => 20)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @faculties }
    end
  end

  # GET /faculties/1
  # GET /faculties/1.json
  def show
    @faculty = Faculty.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @faculty }
    end
  end

  # GET /faculties/new
  # GET /faculties/new.json
  def new
    @legend = "New Faculty"
    @faculty = Faculty.new
    @user_id = nil 
    @users_array = [["",-1]]
    User.all.each do |user|
      if not user.is_student?
        @users_array << [user.email, user.id]
      end
    end
    @prefix_array = [["",""],["Dr.","Dr."],["Prof.","Prof."],["Ms.","Ms."],["Mr.","Mr."],["Mrs.","Mrs."]]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @faculty }
    end
  end

  # GET /faculties/1/edit
  def edit
    @legend = "Edit Faculty"
    @faculty = Faculty.find(params[:id])
    @prefix_array = [["",""],["Dr.","Dr."],["Prof.","Prof."],["Ms.","Ms."],["Mr.","Mr."],["Mrs.","Mrs."]]

    respond_to do |format|
      format.html # edit.html.erb
      format.json { render json: @faculty }
    end
  end

  # POST /faculties
  # POST /faculties.json
  def create
    @faculty = Faculty.new(params[:faculty])

    respond_to do |format|
      if @faculty.save
        format.html { redirect_to [:admin, @faculty], notice: 'Faculty was successfully created.' }
        format.json { render json: @faculty, status: :created, location: @faculty }
      else
        format.html { render action: "new" }
        format.json { render json: @faculty.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /faculties/1
  # PUT /faculties/1.json
  def update
    @faculty = Faculty.find(params[:id])

    respond_to do |format|
      if @faculty.update_attributes(params[:faculty])
        format.html { redirect_to [:admin, @faculty], notice: 'Faculty was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @faculty.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /faculties/1
  # DELETE /faculties/1.json
  def destroy
    @faculty = Faculty.find(params[:id])
    @faculty.destroy

    respond_to do |format|
      format.html { redirect_to admin_faculties_url }
      format.json { head :no_content }
    end
  end
end
