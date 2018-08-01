class UserBooksController < ApplicationController



  def show

  end

  #created by the books_controller
  def new

  end

  #when a book is created the user book is created in the books controller
  def create
    @book = Book.find(params[:book_id])
    @user_book = UserBook.new(user_book_params)
    @user_book.book_id = @book.id
    @user_book.user = current_user
    @user_book.save
    destroy_multiple
    redirect_to book_path(@book)
  end

  def edit
    @book = Book.find(params[:book_id])
    @user = current_user
    @user_book = UserBook.find(params[:id])
  end


  # Not currently used as unable to access from books#show
  def update
    raise
    @book = Book.find(params[:book_id])
    @user_book = UserBook.find(params[:id])
  end


  #when book is removed from bookcase
  def destroy
    @user_book = UserBook.find(params[:id])
    @user_book.destroy
  end

  private
  #user_id on params?
  def user_book_params
    params.require(:user_book).permit(:book_id, :have_or_want, :rating, :_destroy)
  end

  def destroy_multiple
    user_book_array = current_user.user_books.where(user: current_user, book: @book)

    if user_book_array.length == 2

      x = user_book_array.first
      y = user_book_array.last
        if x.have_or_want == false && y.have_or_want == false
           current_user.user_books.destroy_all
        elsif x.have_or_want == false
          x.destroy
        elsif x.have_or_want == true && y.have_or_want == true
          x.destroy

        else
        current_user.user_books.destroy_all

        end

    end
  end


end
