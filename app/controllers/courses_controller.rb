class CoursesController < ApplicationController
  def show
    respond_to do |format|
      format.html { 
        current_user
        render "home/dashboard" 
      }
      
      format.json { 
        course = Course.find(params[:id])

        topics = course.topics.collect do |topic|
          ret = {id: topic.id, title: topic.title}
          ret["sections"] = topic.sections.collect do |section|
            sec = {
              id:               section.id,
              title:            section.title,
              description:      section.description,
              ct_status:        section.ct_status,
            }

            sec["reference"] = section.references.collect do |ref|
              {:book => ref.course_reference.book.title, :indices => ref.indices }
            end
            sec["classes"] = section.classrooms.collect do |cl|
              {id: cl.id, date: cl.date.strftime("%D"), time: cl.time, venue: cl.room}
            end
            sec
          end
          ret
        end
        

        reference_books = course.books.collect do |book|
          book["authors"] = book.authors
          book
        end

        instructors = []
        course.this_year.each do |term|
          term.faculties.each do |faculty|
            instructors << {
              instructor: "#{faculty.prefix} #{faculty.user.name}",
              semester:   term.semester.ordinalize,
              year:       "#{term.academic_year}-#{term.academic_year+1}"
            }
          end
        end

        latest_terms = course.this_year.collect do |term|
          term.id
        end.join(",")
        
        classes = Classroom.where("term_id IN (" + latest_terms + ")").collect do |cl|
          ret = {date: "#{cl.date.strftime('%-d').to_i.ordinalize} #{cl.date.strftime('%b')}", time: cl.time, room: cl.room, term_id: cl.term_id }
          
          ret
        end


        @course = {
          id:              course.id,
          code:            course.subject_code,
          name:            course.name,
          about:           BlueCloth.new(course.about).to_html,
          credits:         course.credits,
          departments:     course.departments,
          classes:         classes,
          topics:          topics,
          instructors:     instructors,
          reference_books: reference_books
        }
        
        render json: @course
      } 
    end
  end
end
