class BookCommentsController < ApplicationController
  before_action :set_book

  def create
    @book_comment = current_user.book_comments.new(book_comment_params)
    @book_comment.book = @book

    if @book_comment.save
      redirect_back fallback_location: book_path(@book), notice: "Comment created."
    else
      # showを再表示するために必要な変数を揃える
      @user = @book.user
      @book_new = Book.new
      @book_comments = @book.book_comments.includes(:user).order(created_at: :desc)
      render "books/show", status: :unprocessable_entity
    end
  end

  def destroy
    comment = @book.book_comments.find(params[:id])

    unless comment.user == current_user
      return redirect_back fallback_location: book_path(@book), alert: "You don't have permission to delete this comment."
    end

    comment.destroy
    redirect_back fallback_location: book_path(@book), notice: "Comment deleted."
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
