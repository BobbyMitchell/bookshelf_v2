class BooksController < ApplicationController
 #skip_before_acti  :authenticate_user!, only: [:index, :show]
  before_action :find_book, only: [:show, :edit, :update, :destroy, :add_to_my_bookshelf, :remove_from_my_bookshelf, :add_to_my_reading_list, :remove_from_my_reading_list]



 def my_books
   @my_books = current_user.user_books.where(have_or_want: true)
 end

 def my_reading_list
   @my_reading_list = current_user.user_books.where(have_or_want: false)
 end


def index
  @books = Book.all
end

def show
  @user_book = UserBook.new
end

def new
   @book = Book.new
end

  def create
    @book = Book.new(book_params)
    #search_terms varible made as GoogleBooks.search won't except variables
    search_terms = "inauthor:#{@book.author}, intitle:#{@book.title}"
    title = @book.title
    books = GoogleBooks.search(search_terms)
    first_book = books.first
    first_book.authors
    first_book.isbn #=> '9781443411080'
    first_book.image_link(:zoom => 6) #=> 'http://bks2.books.google.com/books?id=...
    @book.photo_url = first_book.image_link
    @book.description = first_book.description
    @book.page_count = first_book.page_count
    @book.isbn = first_book.isbn
    if @book.save
      #creates the user_books object
      book_user = UserBook.create(book: @book, user: current_user, have_or_want: @book.have_read)
      redirect_to books_path
    else
      render :new
    end

  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :genre, :photo)
  end
  def find_book
    @book = Book.find(params[:id])
  end

end

