require 'net/imap'

class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    data = params[:user].merge(:admin => false)
    data[:name].split.map(&:capitalize).join(' ')
    @user = User.new(data)

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
        flash[:notice_type] = "alert-danger"
        format.html { redirect_to "/login", notice: "Username or Password is Invalid" }
      elsif @user.save
        session[:user_id] = @user.id
        @user.update_attributes({ :doc_access_token => Digest::MD5.hexdigest(@user.email+Time.now().to_s),
          :sign_in_count        => 1,
          :current_sign_in_at   => Time.now(),
          :current_sign_in_ip   => request.remote_ip 
        })
        
        UserMailer.welcome_email(@user).deliver
        
        if @user.student?
          sub_list = Set.new()
          Course.all.each do |course|
            course.current_term.each do |term|
              if (term.semester+1)/2 == @user.nth_year
                term.departments.each do |dept|
                  if dept.id == @user.department_id 
                    sub_list.add({:term_id => term.id, :user_id => @user.id})
                  end
                end
              end
            end
          end
          sub_list = sub_list.to_a

          sub_status = false
          if sub_list.nil? || sub_list.empty?
            sub_status = true
          else
            sub_status = Subscription.create(sub_list)
          end

          if sub_status
            flash[:notice_type] = "alert-success"
            format.html { redirect_to root_url, notice: 'Thank you for signing up!' }
            format.json { render json: @user, status: :created, location: @user }
          else
            flash[:notice_type] = "alert-danger"
            format.html { redirect_to "/login", notics: "Sorry, failed to save data" }
            format.json { render json: sub_status.errors, status: :unprocessable_entity }
          end
        else
          flash[:notice_type] = "alert-success"
          format.html { redirect_to root_url, notice: 'Thank you for signing up!' }
          format.json { render json: @user, status: :created, location: @user }
        end
      else
        flash[:notice_type] = "alert-danger"
        format.html { redirect_to "/login", notics: "Sorry, failed to save data" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    super
  end
end 
