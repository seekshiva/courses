class DepartmentsController < ApplicationController
  def index
    respond_to do |format|
      format.html { render "home/dashboard" }
      format.json { 
        ret = []
        Department.all.collect do |dept|
          ret << { 
            id:            dept[:id],
            name:          dept[:name],
            rollno_prefix: dept[:rollno_prefix],
            short:         dept[:short]
          }


          if dept.hod.nil?
            ret.last[:hod] = "-"
            ret.last[:hod_email] = 0
          else
            ret.last[:hod] = dept.hod.full_name
            ret.last[:hod_email] = dept.hod.user.email
          end
        end
        render json: ret

      }
    end
  end

  def show
    respond_to do |format|
      format.html { render "home/dashboard" }
	  
      format.json {
        id = params[:id].to_s

        if id.match(/^[[:alpha:]]+$/)
          dept = Department.find_by(:short => params[:id])
        else
          dept = Department.find(params[:id])
        end

        if dept.nil?
          render json: {status: "Page Not Found"}, status: 404 
        else

          ret = {
            id:            dept[:id],
            name:          dept[:name],
            rollno_prefix: dept[:rollno_prefix],
            short:         dept[:short],
            course_listing:         []
          }

          if dept.hod.nil?
            ret[:hod] = "-"
            ret[:hod_email] = 0
          else
            ret[:hod] = dept.hod.full_name
            ret[:hod_email] = dept.hod.user.email
          end
          

          arr, current_sem = [], nil
          dept.terms.each do |term|
            if term.this_year?
              if current_sem != term.semester
                ret[:course_listing] << { semester: current_sem, course_list: arr } if not current_sem.nil?
                arr = []
              end
              current_sem = term.semester
              course = {
                course_id: term.course[:id],
                term_id:   term.id,
                code:      term.course[:subject_code],
                name:      term.course[:name],
                credits:   term.course[:credits]
              } 
              course[:instructors] = term.faculties.collect do |faculty|
                {
                  id:   faculty.id,
                  name: "#{faculty.prefix} #{faculty.user.name}",
                  email: faculty.user.email
                }
              end
              arr << course
            end
          end
          
          if not current_sem.nil?
            ret[:course_listing] << { semester: current_sem, course_list: arr } 
          end
          
          render json: ret
        end
      }
    end
  end
end
