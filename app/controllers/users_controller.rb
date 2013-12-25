class UsersController < ApplicationController
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

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    begin
      @username = params[:user][:email]
      @password = params[:password]

      imap = Net::IMAP.new("mail.nitt.edu")
      imap.login(@username, @password)
      flash[:imap_id] = @username
      
    rescue Net::IMAP::NoResponseError
      @failed = true
    rescue Net::IMAP::BadResponseError
      @failed = true
    rescue
    end
    if not flash[:imap_id] == params[:user][:email]
      @failed = true
    end

    respond_to do |format|
      if @failed
        format.html { redirect_to "/me", notice: "Webmail username/password invalid." }
      elsif @user.save
        session[:user_id] = @user.id
        format.html { redirect_to root_url, notice: 'Thank you for signing up!' }
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

    begin
      @username = params[:user][:email]
      @password = params[:password]

      imap = Net::IMAP.new("mail.nitt.edu")
      imap.login(@username, @password)
      flash[:imap_id] = @username
      
    rescue Net::IMAP::NoResponseError
      @failed = true
    rescue Net::IMAP::BadResponseError
      @failed = true
    rescue
    end
    if not flash[:imap_id] == params[:user][:email]
      @failed = true
    end

    respond_to do |format|
      if @failed
        format.html { redirect_to "/me", notice: "Webmail username/password invalid." }
      elsif @user.update_attributes(params[:user]) 
        session[:user_id] = @user.id
        format.html { redirect_to root_url, notice: 'Thank you for signing up!.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

end
