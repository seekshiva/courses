class CoursesController < ApplicationController
  def show
    respond_to do |format|
      format.html { render "home/dashboard" }
      
      format.json { 
        course = Course.find(params[:id])

        sections = course.latest_term.sections.collect do |section|
          ret = {
            id:          section.id,
            title:       section.title,
            short_title: section.title.length > 35 ? "#{section.title[0,33]}..." : section.title
          }
          ret["topics"] = section.topics.collect do |topic|
            top_ = {
              id:               topic.id,
              title:            topic.title,
              description:      topic.description,
              ct_status:        topic.ct_status,
            }

            top_["reference"] = topic.references.collect do |ref|
              {:book => ref.term_reference.book.title, :indices => ref.indices }
            end
            top_["classes"] = topic.classrooms.collect do |cl|
              {id: cl.id, date: cl.date.strftime("%D"), time: cl.time, venue: cl.room}
            end
            top_
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
          sections:        sections,
          instructors:     instructors,
          reference_books: reference_books
        }
        
        render json: @course
      } 
    end
  end
end
