class TermsController < ApplicationController
  def show
    respond_to do |format|
      format.html { 
        current_user
        render "home/dashboard" 
      }
      
      format.json { 
        term = Term.find(params[:id])

        topics = term.course.topics.collect do |topic|
          ret = {
            id: topic.id,
            title: topic.title,
            short_title: topic.title.length > 35 ? "#{topic.title[0,33]}..." : topic.title
          }
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
        

        reference_books = term.course.books.collect do |book|
          book["authors"] = book.authors
          book
        end

        instructors = []
        term.faculties.each do |faculty|
          instructors << {
            instructor: "#{faculty.prefix} #{faculty.user.name}",
            semester:   term.semester.ordinalize,
            year:       "#{term.academic_year}-#{term.academic_year+1}"
          }
        end

        classes = Classroom.where("term_id = #{term.id}").collect do |cl|
          ret = {date: "#{cl.date.strftime('%-d').to_i.ordinalize} #{cl.date.strftime('%b')}", time: cl.time, room: cl.room, term_id: cl.term_id }
          
          ret
        end


        @term = {
          id:              term.id,
          course: {
            id:            term.course.id,
            code:            term.course.subject_code,
            name:            term.course.name,
            about:           BlueCloth.new(term.course.about).to_html,
            credits:         term.course.credits,
            reference_books: reference_books
          },
          departments:     term.departments,
          classes:         classes,
          topics:          topics,
          instructors:     instructors
        }
        
        render json: @term
      } 
    end
  end
end
