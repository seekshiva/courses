require 'net/imap'

class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    @user = User.new(params[:user].merge(:admin => false))

    logger.debug "########## otha!!"
    begin
      @username = params[:user][:email]
      @password = params[:password]

      imap = Net::IMAP.new("mail.nitt.edu")
      imap.login(@username, @password)
      flash[:imap_id] = @username
      
    logger.debug "########## otha!!"
    rescue Net::IMAP::NoResponseError
      @failed = true
    rescue Net::IMAP::BadResponseError
      @failed = true
    rescue
    end
    if not flash[:imap_id] == params[:user][:email]
      @failed = true
    end

    logger.debug "########## otha!!"
    respond_to do |format|
    logger.debug "########## inn!!"
      if @failed
    logger.debug "########## aaaa!!"
        format.html { redirect_to "/me", notice: "Username or Password is Invalid" }
      elsif @user.save
    logger.debug "########## bbbb!!"
        session[:user_id] = @user.id
        format.html { redirect_to root_url, notice: 'Thank you for signing up!' }
        format.json { render json: @user, status: :created, location: @user }
      else
    logger.debug "########## cccc!!"
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    super
  end
end 
