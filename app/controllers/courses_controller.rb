class CoursesController < ApplicationController
  def show
    current_user
    
    @course = Course.find(params[:id])
    @course["departments"] = @course.departments

    @course["topic_list"] = @course.topics.collect do |topic|
      
      topic["reference"] = topic.references.collect do |ref|
        {:book => ref.course_reference.book.title, :sections => ref.sections }
      end
      topic["classes"] = topic.classrooms.collect do |cl|
        {id: cl.id, date: cl.date.strftime("%D"), time: cl.time, venue: cl.room}
      end
      topic
    end
    @course["reference_books"] = @course.books.collect do |book|
      book["authors"] = book.authors
      book
    end

    instructors = []
    @course.this_year.each do |term|
      term.faculties.each do |faculty|
        instructors << {
          instructor: "#{faculty.prefix} #{faculty.user.name}",
          semester:   term.semester.ordinalize,
          year:       "#{term.academic_year}-#{term.academic_year+1}"
        }
      end
    end
    @course["instructors"] = instructors

    respond_to do |format|
      format.json { render json: @course  }
      format.html { render "home/dashboard" }
    end
  end
end
