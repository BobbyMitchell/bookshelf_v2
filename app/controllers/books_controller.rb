class BooksController < ApplicationController
 skip_before_action :authenticate_user!, only: [:index, :show]
 before_action :find_book, only: [:show, :edit, :update, :destroy, :add_to_my_bookshelf, :remove_from_my_bookshelf, :add_to_my_reading_list, :remove_from_my_reading_list]

 #returns user_books
 def my_books
   @my_books = current_user.user_books.where(have_or_want: true)
 end
 #returns user_books
 def my_reading_list
   @my_reading_list = current_user.user_books.where(have_or_want: false)
 end

 def index
  @books = Book.all
end

def show
  #this user_book is used in the _user_book_form to create a new user_book with the disired have_or_want
  @user_book = UserBook.new
end

def new
 @book = Book.new
end

def create


  @book = Book.new(book_params)
    #search_terms varible made as GoogleBooks.search won't except variables
    search_terms = "inauthor:#{@book.author}, intitle:#{@book.title}, subject: 'Fiction' "
    title = @book.title
    google_books_objects = GoogleBooks.search(search_terms)

    #Google books tends to ingnore subject so this removes non fiction
    google_books = []
    google_books_objects.each do |book|
      if book.categories == "Fiction"
        google_books << book
      end
    end

    if google_books.empty?
      flash.notice = "Couldn't find you're book, please try again."
      redirect_to new_book_path
    else

    first_book = google_books.first

    first_book.image_link(:zoom => 6)
    # title and autors changed from search terms to prevent duplication. ie having Tolkien and J R Tolkien being differant authors
    @book.title = first_book.title
    @book.author = first_book.authors
    #Finf the book if it exists with the same title and author, if not creates it.
    @book = Book.where(title: @book.title, author: @book.author).first_or_create do |book|
      book.photo_url = first_book.image_link
      book.description = first_book.description
      book.page_count = first_book.page_count
      book.isbn = first_book.isbn
      book.created_by = current_user.id
    end
    if @book.save
      redirect_to book_path(@book)
    else
      render :new
    end
  end
end


  def edit
  end

  def update
  end

  def destroy
    @book.destroy
    redirect_to new_book_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :genre, :photo, :user_id)
  end
  def find_book
    @book = Book.find(params[:id])
  end

end

