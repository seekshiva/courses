class DepartmentsController < ApplicationController
  def index
    respond_to do |format|
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
          else
            ret.last[:hod] = dept.hod.full_name
          end
        end
        render json: ret

      }
      format.html {
        current_user
        render "home/dashboard"
      }
    end
  end

  def show
    respond_to do |format|
      format.html {
        current_user
        render "home/dashboard"
      }
      format.json {
        dept = Department.find(params[:id])

        ret = {
          id:            dept[:id],
          name:          dept[:name],
          rollno_prefix: dept[:rollno_prefix],
          short:         dept[:short],
          terms:         []
        }

        if dept.hod.nil?
          ret[:hod] = "-"
        else
          ret[:hod] = dept.hod.full_name
        end
        

        arr, current_sem = [], nil
        dept.terms.each do |term|
          if term.this_year?
            if current_sem != term.semester
              ret[:terms] << { semester: current_sem, course_list: arr } if not current_sem.nil?
              arr = []
            end
            current_sem = term.semester
            course = {
              id:      term.course[:id],
              code:    term.course[:subject_code],
              name:    term.course[:name],
              credits: term.course[:credits]
            } 
            course[:instructors] = term.faculties.collect do |faculty|
              { id:   faculty.id, name: "#{faculty.prefix} #{faculty.user.name}" }
            end
            arr << course
          end
        end
        ret[:terms] << { semester: current_sem, course_list: arr } if not current_sem.nil?

        render json: ret
      }
    end
  end
end
