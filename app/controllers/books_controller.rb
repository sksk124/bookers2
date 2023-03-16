class BooksController < ApplicationController

  before_action :is_matching_login_user, only: [:edit]


  def index
    @book = Book.new
    @books = Book.all
    @user = @book.user
    

  end

  def show
    @book = Book.find(params[:id])
    @books = Book.all
    @user = @book.user
    @new_book = Book.new

  end

  def edit
    is_matching_login_user
    @book = Book.find(params[:id])
  end


  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    redirect_to book_path(@book.id),notice:'You have updated user successfully.'
    else
    render :edit
    end
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
     redirect_to book_path(@book.id), notice:'You have created book successfully.'
    else
      @books = Book.all
     render :index
    end
  end


  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image2.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end


  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_login_user
    @book = Book.find(params[:id])
    if @book.user == current_user
      render :edit
    else
      redirect_to books_path
    end
  end




end
