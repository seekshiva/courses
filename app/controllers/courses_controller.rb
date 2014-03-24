class CoursesController < ApplicationController
  def show
    respond_to do |format|
      format.html { render "home/dashboard" }
      
      format.json { 
        course = Course.find(params[:id])

        render json: {
          id:              course.id,
          code:            course.subject_code,
          name:            course.name,
          about:           BlueCloth.new(course.about).to_html,
          credits:         course.credits,
          departments:     course.departments,
          sections:        course.latest_term.sections.as_json(generic: true),
          reference_books: course.books.as_json
        }

      } 
    end
  end
end
