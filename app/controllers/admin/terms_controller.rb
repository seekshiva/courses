class Admin::TermsController < Admin::BaseController
  # GET /terms
  # GET /terms.json
  def index
    @course = Course.find(params[:course_id])
    @terms = Term.find_all_by_course_id(params[:course_id])
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @terms }
    end
  end

  # GET /terms/1
  # GET /terms/1.json
  def show
    @course = Course.find(params[:course_id])
    @term = Term.find(params[:id])
    @new_faculty = TermFaculty.new
    @new_department = TermDepartment.new

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @term }
    end
  end

  # GET /terms/new
  # GET /terms/new.json
  def new
    @course = Course.find(params[:course_id])
    @term = Term.new
    @legend = "New Term"
    @options = [[1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7],[8,8]]
    
    @departmentslist = Department.all.collect do |dept|
      [dept.name, dept.id]
    end

    @facultieslist = Faculty.all.collect do |faculty|
      [faculty.prefix+" "+faculty.user.name, faculty.id]
    end

    @tab = "new"
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @term }
    end
  end

  # GET /terms/1/edit
  def edit
    @course = Course.find(params[:course_id])
    @term = Term.find(params[:id])
    @legend = "Editing Term"
    @options = [[1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7],[8,8]]

    @departmentslist = Department.all.collect do |dept|
      [dept.name, dept.id]
    end

    @facultieslist = Faculty.all.collect do |faculty|
      [faculty.prefix+" "+faculty.user.name, faculty.id]
    end

    @bookslist = Book.all.collect do |book|
      ["#{book.title} - #{book.publisher} - #{book.edition}", book.id]
    end

    @tab = "edit"
    respond_to do |format|
      format.html # edit.html.erb
      format.json { render json: @term }
    end
  end

  # POST /terms
  # POST /terms.json
  def create
    @course = Course.find(params[:course_id])
    @term = Term.new(params[:term])
    old_term = @course.latest_term

    respond_to do |format|
      if @term.save

        departmentslist = params[:departments]
        departments = Set.new
        if not departmentslist.nil?
          departmentslist.each do |dept|
            if dept.to_s!="0"
              departments.add({ :department_id => dept, :term_id => @term.id })
            end
          end
        end
        departmentslist = departments.to_a

        if departmentslist.nil? || departmentslist.empty?
          @dept_create_status = true
        else
          @dept_create_status = TermDepartment.create(departmentslist)
        end

        facultieslist = params[:faculties]
        faculties = Set.new
        if not facultieslist.nil?
          facultieslist.each do |faculty|
            if faculty.to_s!="0"
              faculties.add({ :faculty_id => faculty, :term_id => @term.id })
            end
          end
        end
        facultieslist = faculties.to_a

        if facultieslist.nil? || facultieslist.empty?
          @faculty_create_status = true
        else
          @faculty_create_status = TermFaculty.create(facultieslist)
        end

        if !old_term.nil?
          # Copy the latest term's books, sections, topics and references
          # Copying term's books
          term_ref = TermReference.where(:term_id => old_term.id)
          term_books = Array.new()
          term_ref.each do |book|
            term_books << {:term_id => @term.id, :book_id => book.book_id}
          end
          if term_books.nil? || term_books.empty?
            term_books = true
          else
            term_books = TermReference.create(term_books)
          end

          # Copying sections, topics and references
          # Copying sections
          sections = Section.where(:term_id => old_term.id)
          term_sections = Array.new()
          sections.each do |section|
            term_sections << {:term_id => @term.id, :title => section.title}
          end
          if term_sections.nil? || term_sections.empty?
            term_sections = true
          else
            term_sections = Section.create(term_sections)
          end

          # Copying topics
          term_topics = Array.new()
          old_topics = Array.new()
          sections.each_index do |i|
            topics = Topic.where(:section_id => sections[i].id )
            topics.each do |topic|
              old_topics << topic
              term_topics << {:title => topic.title, :description => topic.description, :ct_status => topic.ct_status, :section_id => term_sections[i].id}
            end
          end
          if term_topics.nil? || term_topics.empty?
            term_topics = true
          else
            term_topics = Topic.create(term_topics)
          end

          # Copying references
          term_refs = Array.new()
          old_topics.each_index do |i|
            refs = Reference.where(:topic_id => old_topics[i].id)
            refs.each do |ref|
              term_refs << {:term_reference_id => ref.term_reference_id, :indices => ref.indices, :topic_id => term_topics[i].id}
            end
          end
          if term_refs.nil? || term_refs.empty?
            term_refs = true
          else
            term_refs = Reference.create(term_refs)
          end
        else
          term_books = term_sections = term_topics = term_refs = true
        end

        if term_books and term_sections and term_topics and term_refs and @dept_create_status and @faculty_create_status
          format.html { redirect_to [:admin, @course, :terms], notice: 'Term was successfully created.' }
          format.json { render json: @term, status: :created, location: @term }
        else
          format.html { render action: "new" }
          format.json { render json: (term_books.errors << term_sections.errors << term_topics.errors << term_refs.errors ).flatten , status: :unprocessable_entity }
        end
      else
        format.html { render action: "new" }
        format.json { render json: @term.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /terms/1
  # PUT /terms/1.json
  def update
    @course = Course.find(params[:course_id])
    @term = Term.find(params[:id])
    @term.course_id = params[:term_course_id]

    bookslist = params[:books]
    books = Set.new
    if not bookslist.nil?
      bookslist.each do |book|
        if book.to_s!="0"
          books.add({ :book_id => book, :term_id => params[:id] })
        end
      end
    end
    bookslist = books.to_a

    @book_destroy_status = TermReference.destroy_all(:term_id => params[:id])
    if bookslist.nil? || bookslist.empty?
      @book_create_status = true
    else
      @book_create_status = TermReference.create(bookslist)
    end
    
    departmentslist = params[:departments]
    departments = Set.new
    if not departmentslist.nil?
      departmentslist.each do |dept|
        if dept.to_s!="0"
          departments.add({ :department_id => dept, :term_id => params[:id] })
        end
      end
    end
    departmentslist = departments.to_a

    @dept_destroy_status = TermDepartment.destroy_all(:term_id => params[:id])
    if departmentslist.nil? || departmentslist.empty?
      @dept_create_status = true
    else
      @dept_create_status = TermDepartment.create(departmentslist)
    end

    facultieslist = params[:faculties]
    faculties = Set.new
    if not facultieslist.nil?
      facultieslist.each do |faculty|
        if faculty.to_s!="0"
          faculties.add({ :faculty_id => faculty, :term_id => params[:id] })
        end
      end
    end
    facultieslist = faculties.to_a

    @faculty_destroy_status = TermFaculty.destroy_all(:term_id => params[:id])
    if facultieslist.nil? || facultieslist.empty?
      @faculty_create_status = true
    else
      @faculty_create_status = TermFaculty.create(facultieslist)
    end

    respond_to do |format|
      if @term.update_attributes(params[:term]) && @dept_destroy_status && @dept_create_status && @faculty_destroy_status && @faculty_create_status && @book_destroy_status && @book_create_status
        format.html { redirect_to [:admin, @course, @term], notice: 'Term was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @term.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /terms/1
  # DELETE /terms/1.json
  def destroy
    @course = Course.find(params[:course_id])
    @term = Term.find(params[:id])
    @term.destroy

    respond_to do |format|
      format.html { redirect_to admin_course_terms_url(@course) }
      format.json { head :no_content }
    end
  end
end
