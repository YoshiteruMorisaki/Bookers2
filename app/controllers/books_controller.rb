class BooksController < ApplicationController
  before_action :identify_book, only: %i[show edit update destroy]
  before_action :is_maching_user, only: %i[edit update destroy]

  def index
    @user  = current_user
    @book  = Book.new
    @books = Book.includes(:user).order(created_at: :desc)
  end

  def show
    @user = @book.user
    @book_new = Book.new
  end

  def create
    @book = current_user.books.new(book_params)

    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      case params[:context]
      when "books_index"
        @user  = current_user
        @books = Book.includes(:user).order(created_at: :desc)
        render :index, status: :unprocessable_entity
      else
        @user  = current_user
        @books = @user.books.order(created_at: :desc)
        render "users/show", status: :unprocessable_entity
      end
    end
  end

  def edit; end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path, notice: "Book deleted."
  end

  private

  def identify_book
    @book = Book.find(params[:id])
  end

  def is_maching_user
    unless @book.user == current_user
      redirect_to books_path, alert: "You don't have permission to access."
    end
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
