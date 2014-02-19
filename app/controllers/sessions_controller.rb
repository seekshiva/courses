require 'net/imap'

class SessionsController < Devise::SessionsController

  # POST /login
  def create
    @username = params[:username]
    @redirect_url = params[:redirect_url]

    respond_to do |format|
      format.html do

        if authenticate(@username, params[:password])

          @user = User.find_by email: @username

          if @user.nil?
            @user = User.new email: @username, name: "", activated: false, admin: false
            @user.save
          end

          if @user.activated?
            signin_as @user
            redirect_to @redirect_url || root_url
          else
            flash[:imap_id] = @username
            redirect_to getting_started_path
          end
          
        else
          flash[:notice_type] = "alert-danger"
          redirect_to login_path, notice: "Username or Password is Invalid"
        end
      end
    end
  end

  # DELETE /signout
  def destroy
    if session[:admin_user_id].nil?
      @user.update_attributes({ :doc_access_token => nil })      
      session[:user_id] = nil

      redirect_to root_url, notice: "You have successfully logged out.", notice_type: "alert-success"
    else
      session[:user_id] = session[:admin_user_id]
      session[:admin_user_id] = nil

      redirect_to "/admin"
    end
  end

  protected

  def signin_as(user)
    user.update_access_token
    user.update_attributes({ 
                             sign_in_count:      user.sign_in_count+1,
                             last_sign_in_at:    user.current_sign_in_at,
                             current_sign_in_at: Time.now(),
                             last_sign_in_ip:    user.current_sign_in_ip,
                             current_sign_in_ip: request.remote_ip
                           })
    session[:user_id] = user.id
  end

  # IMAP authentication

  def authenticate(username, password)
    begin
      imap = Net::IMAP.new("mail.nitt.edu")
      imap.login(@username, params[:password])
      return true
    rescue Net::IMAP::NoResponseError
    rescue Net::IMAP::BadResponseError
    rescue Exception => e
      # uncomment the following line to login as anyone when not connected to the internet
      # return true
    end
    return false
  end

end
