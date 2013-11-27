class Admin::BooksController < Admin::BaseController
  # GET /books
  # GET /books.json
  def index
    @page_no = params[:page] || 1
    @books = Book.paginate(:page => @page_no, :per_page => 20)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @books }
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @book = Book.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @book }
    end
  end

  # GET /books/new
  # GET /books/new.json
  def new
    @book = Book.new
    @legend = "New Books"

    @authorslist = []
    @authorslist << ["--None Selected--", 0]
    Author.all.each do |author|
      @authorslist << ["#{author.name}", author.id]
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @book }
    end
  end

  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id])
    @legend = "Edit Books"

    @authorslist = []
    @authorslist << ["--None Selected--", 0]
    Author.all.each do |author|
      @authorslist << ["#{author.name}", author.id]
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @book }
    end
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(params[:book])

    respond_to do |format|
      if @book.save
        authorlist = params[:authors]
        authors = Set.new
        authorlist.each do |author|
          if author.to_s!="0"
            authors.add({ :book_id => @book.id, :author_id => author })
          end
        end
        authorlist = authors.to_a

        bookauthor = BookAuthor.create(authorlist)

        if bookauthor
          format.html { redirect_to [:admin, @book], notice: 'Book was successfully created.' }
          format.json { render json: @book, status: :created, location: @book }
        else
          format.html { render action: "new" }
          format.json { render json: @bookauthor.errors, status: :unprocessable_entity }
        end
      else
        format.html { render action: "new" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /books/1
  # PUT /books/1.json
  def update
    @book = Book.find(params[:id])

    authorlist = params[:authors]
    authors = Set.new
    authorlist.each do |author|
      if author.to_s!="0"
        authors.add({ :book_id => params[:id], :author_id => author })
      end
    end
    authorlist = authors.to_a

    destroy_status = BookAuthor.destroy_all(:book_id => params[:id])
    create_status = BookAuthor.create(authorlist)

    respond_to do |format|
      if @book.update_attributes(params[:book]) and destroy_status and create_status
        format.html { redirect_to [:admin, @book], notice: 'Book was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    respond_to do |format|
      format.html { redirect_to admin_books_url }
      format.json { head :no_content }
    end
  end
end
