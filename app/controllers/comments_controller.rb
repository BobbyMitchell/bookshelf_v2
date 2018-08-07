class CommentsController < ApplicationController

before_action :set_book

def new
  @comment = Comment.new
end

def create
  @comment = Comment.new(comment_params)
  @comment.book = Book.find(params[:book_id])
  @comment.user = current_user
  @comment.save
  redirect_to book_path(@book)
end

private

def set_book
  @book = Book.find(params[:book_id])
end

def comment_params
  params.require(:comment).permit(:content)
end
end
