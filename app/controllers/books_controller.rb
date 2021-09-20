class BooksController < ApplicationController
  
  def index
    @books=Book.all
    @book=Book.new
    @user=User.find(current_user.id)
  end
  
  def create
    @book=Book.new(book_params)
    @book.user_id=current_user.id
    # 投稿成功でメッセージ books#showで表示
    if @book.save
      flash[:notice_create]="You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books=Book.all
      @user=User.find(current_user.id)
      render :index
    end
  end


  def show
    @book=Book.find(params[:id])
    @newbook=Book.new
    @user=@book.user
  end
  
  def edit
    @book=Book.find(params[:id])
  end
  
  def update
    @book=Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice_update]="You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end
  
  def destroy
    @book=Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end
  
  private
  def book_params
    params.require(:book).permit(:title,:body)
  end

end
