class BooksController < ApplicationController
 #skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :find_book, only: [:show, :edit, :update, :destroy, :add_to_my_bookshelf, :remove_from_my_bookshelf, :add_to_my_reading_list, :remove_from_my_reading_list]


#My_bookshelf adds and removes books from bookshelf
 def my_books
   @my_books = current_user.user_books.where(have_or_want: true)
 end
#These methods are now covered by the user_books controller
 # def add_to_my_bookshelf
 #    current_user.books.delete(@book)
 #    @book.have_read = true
 #    userbook = UserBook.create(book: @book, user: current_user, have_or_want: true)
 #   raise
 #   redirect_to book_path
 # end

 # def remove_from_my_bookshelf
 #   current_user.books.delete(@book)
 #   @book.have_read = false
 #   redirect_to book_path
 # end

# my_reading_list returns user_books not books
 # def add_to_my_reading_list
 #  current_user.books.delete(@book)
 #  userbook = UserBook.create(book: @book, user: current_user, have_or_want: false)
 #  @book.have_read = false
 #  @book.save
 #   redirect_to book_path
 # end

 # def remove_from_my_reading_list
 #    current_user.books.delete(@book)
 #   redirect_to book_path
 # end
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
    #@user = current_user
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    #if statement so if book does not meet validations it does not lose data
    if @book.save
      #creates the user_books object
      book_user = UserBook.create(book: @book, user: current_user, have_or_want: @book.have_read)
      redirect_to books_path
    else
      render :new
    end

  end

  def edit
``
  end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book)
    else
      render :new
    end
  end

  def destroy

    @book.destroy
    redirect_to books_path

  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :rating, :have_read, :genre)
  end
  def find_book
    @book = Book.find(params[:id])
  end

end

