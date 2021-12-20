class BooksController < ApplicationController

  def index
    @books=Book.all
    @newbook=Book.new
    @user=User.find(current_user.id)
    # いいね多い順に並び替え
    # (:favorites)にはbookモデルのアソシエーションで定義したものを入れる
    # 今回は(:favorites)もしくは(:favorite_uses)
    @books=Book.includes(:favorites).sort{|a,b| b.favorites.length <=> a.favorites.size}
  end

  def create
    @newbook=Book.new(book_params)
    @newbook.user_id=current_user.id
    # 投稿成功でメッセージ books#showで表示
    if @newbook.save
      flash[:notice]="You have created book successfully."
      redirect_to book_path(@newbook.id)
      # redirect_to book_path(@newbook.id),notice:"You have created book successfully." にするとapplication.htmlで表示できる
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
    @book_comment=BookComment.new
    #閲覧数表示
    unless ViewCount.find_by(user_id: current_user.id, book_id: @book.id)
      @book.view_counts.create(user_id: current_user.id)
    end
  end

  def edit
    @book=Book.find(params[:id])
    if @book.user == current_user
      render :edit
    else
      redirect_to books_path
    end
  end

  def update
    @book=Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice_book]="You have updated book successfully."
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
