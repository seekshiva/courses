class Admin::UsersController < Admin::BaseController
  # GET /users
  # GET /users.json
  def index
    @page_no = params[:page] || 1
    if params[:search]
      @users = User.where("email like ? or name like ? or phone like ?", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%").paginate(:page => @page_no, :per_page => 20)
    else
      @users = User.paginate(:page => @page_no, :per_page => 20)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
    @legend = "New User"
    @departments_array = Department.all.map do |department|
      ["#{department.name}", department.id]
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    @legend = "Edit User"
    @departments_array = Department.all.map do |department|
      ["(#{department.short}) #{department.name}", department.id]
    end
    @dept = @user.department.id

    respond_to do |format|
      format.html # edit.html.erb
      format.json { render json: @user }
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to [:admin, @user], notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    # :admin param is not getting sent from browser if checkbox is off
    # so, forcing :admin to false if the field is not found in payload
    params[:user][:admin]     = "false" if params[:user][:admin].nil?
    params[:user][:blacklist] = "false" if params[:user][:blacklist].nil?

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to [:admin, @user], notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to admin_users_url }
      format.json { head :no_content }
    end
  end

  def switch_to
    user = User.where(email: params[:email]).first
    if not user.nil?
      session[:admin_user_id] = session[:user_id]
      session[:user_id] = user.id
      redirect_to root_url
    else
      flash[:notice_type] = 'alert-danger'
      redirect_to "/admin", notice: "You have quit from God mode."
    end
  end
end
