class ProfileController < ApplicationController

  before_action :require_user, except: [:show]

  def show
    respond_to do |format|
      format.html {
        render "home/dashboard"
      }
      format.json {
        id = params[:id].to_s
        profile = @user

        if params[:id].to_s != "me"
          profile = User.find_by email: params[:id]
        end

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
            ret[:subs] = Subscription.where(:user_id => profile.id).collect do |sub|
              {
                id:           sub.id, 
                term_id:      sub.term_id,
                course_name:  sub.term.course.name,
                course_id:    sub.term.course_id,
                current:      sub.term.is_current?,
                this_year:    sub.term.this_year?,
                year:         sub.term.year,
                sem:          sub.term.semester.ordinalize
              }
            end
          else
            faculty = Faculty.find_by user_id: profile.id

            ret[:student] = true;
            if !faculty.nil?
              ret[:student] = false;
              info = {
                student:      false,
                prefix:       faculty.prefix,
                about:        faculty.about,
                designation:  faculty.designation
              }

              ret[:classes] = TermFaculty.where(:faculty_id => faculty.id).collect do |tf|
                {
                  id:           tf.id,
                  term_id:      tf.term_id,
                  course_name:  tf.term.course.name,
                  this_year:    tf.term.this_year?,
                  current:      tf.term.is_current?,
                  year:         tf.term.year,
                  sem:          tf.term.semester.ordinalize
                }
              end
            end
            ret.reverse_merge!(info)
          end
          if !@user.nil? && profile.email == @user.email
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

  def update
    @user = User.find(params[:user][:user_id])

    faculty_status = true
    if not params[:user][:student]
      @faculty = Faculty.find_by user_id: params[:user][:user_id]

      update = {
        prefix:       params[:user][:prefix],
        about:        params[:user][:about],
        designation:  params[:user][:designation].split.map(&:capitalize).join(' ')
      }

      faculty_status = @faculty.update_attributes(update)
    end
    
    update = {
      name:       params[:user][:name].split.map(&:capitalize).join(' '),
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
