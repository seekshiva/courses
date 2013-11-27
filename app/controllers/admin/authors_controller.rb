class Admin::AuthorsController < Admin::BaseController
  # GET /authors
  # GET /authors.json
  def index
    @page_no = params[:page] || 1
    @authors = Author.paginate(:page => @page_no, :per_page => 20)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @authors }
    end
  end

  # GET /authors/1
  # GET /authors/1.json
  def show
    @author = Author.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @author }
    end
  end

  # GET /authors/new
  # GET /authors/new.json
  def new
    @author = Author.new
    @legend = "New Author"

    @bookslist = []
    @bookslist << ["--None Selected--", 0]
    Book.all.each do |book|
      @bookslist << ["#{book.title} - #{book.publisher} - #{book.edition}", book.id]
    end
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @author }
    end
  end

  # GET /authors/1/edit
  def edit
    @author = Author.find(params[:id])
    @legend = "Edit Author"
    
    @bookslist = []
    @bookslist << ["--None Selected--", 0]
    Book.all.each do |book|
      @bookslist << ["#{book.title} - #{book.publisher} - #{book.edition}", book.id]
    end

    respond_to do |format|
      format.html # edit.html.erb
      format.json { render json: @author }
    end
  end

  # POST /authors
  # POST /authors.json
  def create
    @author = Author.new(params[:author])

    respond_to do |format|
      if @author.save
        booklist = params[:books]
        books = Set.new
        booklist.each do |book|
          if book.to_s!="0"
            books.add({ :book_id => book, :author_id => @author.id })
          end
        end
        booklist = books.to_a

        @bookauthor = BookAuthor.create(booklist)

        if bookauthor
          format.html { redirect_to [:admin, @author], notice: 'Author was successfully created.' }
          format.json { render json: @author, status: :created, location: @author }
        else
          format.html { render action: "new" }
          format.json { render json: @bookauthor.errors, status: :unprocessable_entity }
        end
      else
        format.html { render action: "new" }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /authors/1
  # PUT /authors/1.json
  def update
    @author = Author.find(params[:id])

    booklist = params[:books]
    books = Set.new
    booklist.each do |book|
      if book.to_s!="0"
        books.add({ :book_id => book, :author_id => params[:id] })
      end
    end
    booklist = books.to_a

    destroy_status = BookAuthor.destroy_all(:author_id => params[:id])
    create_status = BookAuthor.create(booklist)
    
    respond_to do |format|
      if @author.update_attributes(params[:author]) and destroy_status and create_status
        format.html { redirect_to [:admin, @author], notice: 'Author was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /authors/1
  # DELETE /authors/1.json
  def destroy
    @author = Author.find(params[:id])
    @author.destroy

    respond_to do |format|
      format.html { redirect_to admin_authors_url }
      format.json { head :no_content }
    end
  end
end
