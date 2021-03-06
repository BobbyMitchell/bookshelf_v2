class UserBooksController < ApplicationController


  def their_books
    x = params[:user_id].to_i
    @their_books = UserBook.where(user: x)
  end


  def index
    raise
  end

  #currently being used to show other users bookcases. To be moved.
  def show
    x = params[:id].to_i
    @their_books = UserBook.where(user: x)
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
    params.require(:user_book).permit(:book_id, :have_or_want, :rating, :user_id, :_destroy)
  end


  # As a new user book is created instead of the oringinal edited this mehod deletes either the one which is not needed or both.
  def destroy_multiple
    user_book_array = current_user.user_books.where(user: current_user, book: @book)
    #if a user book is 'changed' there will be 2 instances. A 'new' user_book will only have on instance so will not be effected.
    if user_book_array.length == 2
      x = user_book_array.first
      y = user_book_array.last
      #remove from reading list
      if x.have_or_want == false && y.have_or_want == false
         current_user.user_books.destroy_all
      #move to bookshelf from reading list
      elsif x.have_or_want == false
        x.destroy
      #on bookshelf and rating added
      elsif x.have_or_want == true && y.have_or_want == true
        x.destroy
      #removed from bookshelf
      else
      current_user.user_books.destroy_all
      end
    end
  end


end
