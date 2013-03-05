class CoursesController < ApplicationController
  def show
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
    if @course.current_term
      @course["current"] = {
        semester: @course.current_term.semester.ordinalize,
        year:     "#{@course.current_term.academic_year}-#{@course.current_term.academic_year+1}"
      } 
    end

    respond_to do |format|
      format.json { render json: @course  }
      format.html { render "home/dashboard" }
    end
  end
end
