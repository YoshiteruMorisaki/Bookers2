class UsersController < ApplicationController

  allow_unauthenticated_access only: %i[ new create ]
  before_action :identify_user, only: %i[show edit update]
  before_action :is_matching_login_user, only: %i[edit update]

  def new
    @user = User.new
  end

  def show
    @books = @user.books.order(created_at: :desc)
    @book  = Book.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user), notice: 'Welcome! You have signed up successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @users = User.order(:id)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def identify_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email_address, :password, :password_confirmation)
  end

  def is_matching_login_user
    unless @user == current_user
      redirect_to user_path(current_user), alert: "権限がありません"
    end
  end

end
