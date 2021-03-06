class Admin::CoursesController < Admin::BaseController
  # GET /courses
  # GET /courses.json
  def index
    respond_to do |format|
      @page_no = params[:page] || 1
      if params[:search]
        @courses = Course.where("subject_code like ? or name like ?", "%#{params[:search]}%", "%#{params[:search]}%").paginate(:page => @page_no, :per_page => 20)
      else
        @courses = Course.paginate(:page => @page_no, :per_page => 20)
      end
      
      if params[:code] and params[:code].empty?
        format.html { redirect_to admin_courses_path }
        format.json { redirect_to admin_courses_path }
      else
        format.html # index.html.erb
        format.json { render json: @courses }
      end
    end
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    course_id = params[:id]||params[:course_id]
    @course = Course.find(course_id)
    @tab = params[:tab] || "info"
    
    @course_obj = Hash.new
    @course_obj["references"] = @course.books.uniq

    @course_obj["instructors"] = []
    @course_obj["departments"] = []
    @course.this_year.each do |term|
      term.faculties.each do |faculty|
        @course_obj["instructors"] << {
          instructor: "#{faculty.prefix} #{faculty.user.name}",
          semester:   term.semester.ordinalize,
          year:       "#{term.academic_year}-#{term.academic_year+1}"
        }
      end
      term.departments.each do |department|
        @course_obj["departments"] << {
          name: department.name.capitalize,
          short: department.short
        }
      end
    end
    @course_obj["departments"] = @course_obj["departments"].uniq
    @course_obj["instructors"] = @course_obj["instructors"].uniq

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @course }
    end
  end

  # GET /courses/new
  # GET /courses/new.json
  def new
    @legend = "New Course"
    @course = Course.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @course }
    end
  end

  # GET /courses/1/edit
  def edit
    @course = Course.find(params[:id] || params[:course_id])

    @sem_options = [[1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7],[8,8]]

    @new_term = Term.new
    @new_section = @course.sections.build
    @current_ac_year = Time.now.year.to_i
    @current_ac_year -= Time.now.month<6 ? 1 : 0
    
    @departmentslist = Department.all.collect do |dept|
      [dept.name, dept.id]
    end

    @facultieslist = Faculty.all.collect do |faculty|
      [faculty.prefix+" "+faculty.user.name, faculty.id]
    end
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @course }
    end
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(params[:course])

    respond_to do |format|
      if @course.save
        format.html { redirect_to [:admin, @course], notice: 'Course was successfully created.' }
        format.json { render json: @course, status: :created, location: @course }
      else
        format.html { render action: "new" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /courses/1
  # PUT /courses/1.json
  def update
    @course = Course.find(params[:id])

    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html { redirect_to [:admin, @course], notice: 'Course was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course = Course.find(params[:id])
    @course.destroy

    respond_to do |format|
      format.html { redirect_to admin_courses_url }
      format.json { head :no_content }
    end
  end
end
