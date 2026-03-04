class FavoritesController < ApplicationController
  before_action :set_book

  def create
    current_user.favorites.create!(book: @book)
    redirect_back fallback_location: books_path
  rescue ActiveRecord::RecordNotUnique
    redirect_back fallback_location: books_path
  end

  def destroy
    current_user.favorites.find_by!(book: @book).destroy
    redirect_back fallback_location: books_path
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end
  
end
