class TermsController < ApplicationController
  def show
    respond_to do |format|
      format.html { render "home/dashboard" }
      
      format.json { 
        term = Term.find(params[:id])

        sections = term.sections.collect do |section|
          ret = {
            id:               section.id,
            title:            section.title,
            short_title:      section.title.length > 30 ? "#{section.title[0,28]}..." : section.title,
            show_short_title: section.title.length > 30
          }
          ret["topics"] = section.topics.collect do |topic|
            top_ = {
              id:               topic.id,
              title:            topic.title,
              description:      topic.description,
              ct_status:        topic.ct_status,
            }

            top_["reference"] = topic.references.uniq.collect do |ref|
              {:book => ref.term_reference.book.title, :indices => ref.indices }
            end
            top_["classes"] = topic.classrooms.collect do |cl|
              {id: cl.id, date: cl.date.strftime("%D"), time: cl.time, venue: cl.room}
            end
            top_
          end
          ret
        end
        
        attachments = term.documents.collect do |doc|
          {
            id:         doc.id,
            name:       doc.document.original_filename,
            url:        doc.document.url
          }
        end

        reference_books = term.course.books.uniq.collect do |book|
          new_book = book
          new_book["authors"] = book.authors
          new_book["cover"] = book.book_cover.nil? ? false : book.book_cover.cover.url(:thumb)
          new_book
        end

        instructors = []
        term.faculties.each do |faculty|
          instructors << {
            instructor: "#{faculty.prefix} #{faculty.user.name}",
            email:      faculty.user.email,
            semester:   term.semester.ordinalize,
            year:       "#{term.academic_year}-#{term.academic_year+1}",
            about:      BlueCloth.new(faculty.about).to_html
          }
        end

        classes = Classroom.where("term_id = #{term.id}").collect do |cl|
          ret = {date: "#{cl.date.strftime('%-d').to_i.ordinalize} #{cl.date.strftime('%b')}", time: cl.time, room: cl.room, term_id: cl.term_id }
          
          ret
        end

        subscription = term.subscriptions.where(:user_id => @user.id).first
        sub = Hash.new
        if subscription.nil?
          sub = {:id => nil, :term_id => term.id, :user_id => @user.id, :attending => nil}
        else 
          sub = { :id => subscription.id, 
                  :term_id => term.id, 
                  :user_id => @user.id, 
                  :attending => subscription.attending
                }
        end

        @term = {
          id:              term.id,
          course: {
            id:              term.course.id,
            code:            term.course.subject_code,
            name:            term.course.name,
            about:           BlueCloth.new(term.course.about).to_html,
            credits:         term.course.credits,
            reference_books: reference_books
          },
          departments:     term.departments,
          classes:         classes,
          sections:        sections,
          attachments:     attachments,
          instructors:     instructors,
          subscription:    sub
        }
        
        render json: @term
      } 
    end
  end
end
