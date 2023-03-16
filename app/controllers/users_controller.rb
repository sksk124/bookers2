class UsersController < ApplicationController

  before_action :is_matching_login_user, only: [ :update]
  before_action :is_matching_login_user_edit, only: [ :edit]



  def index
    @book = Book.new
    @books = Book.all
    @user = @book.user
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end

  def update

    @user = User.find(params[:id])
    if @user.update(user_params)
    redirect_to user_path(current_user.id),notice:'You have updated user successfully.'
    else
      render :edit
    end
  end


   private

   def user_params
     params.require(:user).permit(:name, :email, :password, :introduction, :profile_image)
   end


  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to books_path
    end
  end

  def is_matching_login_user_edit
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end

end
