class BooksController < ApplicationController
  
  def index
    @books=Book.all
    @book=Book.new
  end
  
  def create
    @book=Book.new(book_params)
    @book.user_id=current_user.id
    @book=Book.save
    redirect_to book_path(@book.id)
  end

  def show
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  private
  def boook_params
    params.require(:book).permit(:title,:body)
  end

end
