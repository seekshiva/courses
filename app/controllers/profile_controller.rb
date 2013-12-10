class ProfileController < ApplicationController
  def index
    respond_to do |format|
      format.html {
        current_user
        render "home/dashboard"
      }
      format.json {
        render json: ""
      }
    end
  end

  def show
    respond_to do |format|
      current_user
      format.html {
        render "home/dashboard"
      }
      format.json {
        id = params[:id].to_s
        profile = @user
        profile = User.find_by_email(params[:id]) if params[:id].to_s != "me"

        if profile.nil? && !id.match(/^[[:alpha:]]+$/)
          profile = User.find(params[:id])
        end

        ret = Hash.new
        if not profile.nil?
          ret = {   
                user_id:            profile.id,
                found:              true,
                name:               profile.name,
                email:              profile.email,
                department:         profile.department.name,
                department_short:   profile.department.short,
                phone:              profile.phone,
                avatar:             profile.avatar.nil? ? "" : profile.avatar.pic.url(:large),
                avatar_id:          profile.avatar.nil? ? 0 : profile.avatar_id
            }
          if profile.is_student?
            ret[:student] = true
          else
            faculty = Faculty.find_by_user_id(profile.id)
            info = {
              student:      false,
              prefix:       faculty.prefix,
              about:        faculty.about,
              designation:  faculty.designation
            }
            ret.reverse_merge!(info)
          end
          if profile.email == @user.email
            ret[:edit] = true
          else 
            ret[:edit] = false
          end
          render :json => ret
        else
          render :json => {found: false}          
        end
      }
    end
  end

  def edit
    respond_to do |format|
      current_user
      format.html {
        render "home/dashboard"
      }
    end
  end

  def update
    @user = User.find(params[:user][:user_id])

    faculty_status = true
    if not params[:user][:student]
      @faculty = Faculty.find_by_user_id(params[:user][:user_id])

      update = {
        prefix:       params[:user][:prefix],
        about:        params[:user][:about],
        designation:  params[:user][:designation]
      }

      faculty_status = @faculty.update_attributes(update)
    end
    
    update = {
      name:       params[:user][:name],
      phone:      params[:user][:phone],
      avatar_id:  params[:user][:avatar_id]
    }

    respond_to do |format|
      if @user.update_attributes(update) && faculty_status
        format.html 
        format.json { render json: "saved" }
      else
        format.html 
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end