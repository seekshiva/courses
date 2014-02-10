class TermsController < ApplicationController

  before_action :require_user

  def show
    respond_to do |format|
      format.html { render "home/dashboard" }
      
      format.json { 
        noti = Notification.new()
        noti.send_notification(@user, "You have visited a term.")
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

            top_["reference"] = topic.references.collect do |ref|
              { 
                :id => ref.id,
                :term_ref_id => ref.term_reference.id,
                :book_id => ref.term_reference.book.id,
                :book => ref.term_reference.book.title, 
                :indices => ref.indices 
              }
            end
            top_["notes"] = topic.topic_documents.collect do |topic_doc|
              {
                :id => topic_doc.id,
                :note_id => topic_doc.document.id,
                :name => topic_doc.document.document.original_filename,
                :url => topic_doc.document.document.url
              }
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

        reference_books = term.term_references.collect do |item|
          {
            id:             item.book.id,
            term_ref_id:         item.id,
            authors:        item.book.authors,
            cover:          item.book.book_cover.nil? ? false : item.book.book_cover.cover.url(:thumb),
            title:          item.book.title,
            publisher:      item.book.publisher,
            edition:        item.book.edition,
            isbn:           item.book.isbn,
            book_cover_id:  item.book.book_cover_id,
            year:           item.book.year,
            online_retail_url: item.book.online_retail_url,
          }
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
        
        if not @user.is_student?
          faculty = Faculty.where(:user_id => @user.id)
          if !faculty.nil? || !faculty.empty?
            sub_list = term.subscriptions.collect do |sub|
              {
                name: sub.user.name ,
                email: sub.user.email
              }
            end
            @term[:sub_list] = sub_list
            @term[:faculty] = true
          end
        end
        
        render json: @term
      } 
    end
  end
end
