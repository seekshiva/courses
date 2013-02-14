class Admin::BookAuthorsController < ApplicationController
  # GET /book_authors
  # GET /book_authors.json
  def index
    @book_authors = BookAuthor.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @book_authors }
    end
  end

  # GET /book_authors/1
  # GET /book_authors/1.json
  def show
    @book_author = BookAuthor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @book_author }
    end
  end

  # GET /book_authors/new
  # GET /book_authors/new.json
  def new
    @book_author = BookAuthor.new
    @legend = "New Book Author"
    @books_array = Book.all.map do |book|
      [book.title, book.id]
    end
    @authors_array = Author.all.map do |author|
      [author.name, author.id]
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @book_author }
    end
  end

  # GET /book_authors/1/edit
  def edit
    @book_author = BookAuthor.find(params[:id]) 
    @legend = "Edit Book Author"
    @books_array = Book.all.map do |book|
      [book.title, book.id]
    end
    @authors_array = Author.all.map do |author|
      [author.name, author.id]
    end

    respond_to do |format|
      format.html # edit.html.erb
      format.json { render json: @book_author }
    end
  end

  # POST /book_authors
  # POST /book_authors.json
  def create
    @book_author = BookAuthor.new(params[:book_author])

    respond_to do |format|
      if @book_author.save
        format.html { redirect_to [:admin, @book_author], notice: 'Book author was successfully created.' }
        format.json { render json: @book_author, status: :created, location: @book_author }
      else
        format.html { render action: "new" }
        format.json { render json: @book_author.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /book_authors/1
  # PUT /book_authors/1.json
  def update
    @book_author = BookAuthor.find(params[:id])

    respond_to do |format|
      if @book_author.update_attributes(params[:book_author])
        format.html { redirect_to [:admin, @book_author], notice: 'Book author was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @book_author.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /book_authors/1
  # DELETE /book_authors/1.json
  def destroy
    @book_author = BookAuthor.find(params[:id])
    @book_author.destroy

    respond_to do |format|
      format.html { redirect_to admin_book_authors_url }
      format.json { head :no_content }
    end
  end
end
