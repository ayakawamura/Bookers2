class BookCommentsController < ApplicationController
  before_action :ensure_correct_user, only: [:destroy]

  def create
    @book=Book.find(params[:book_id])
    book_comment=current_user.book_comments.new(book_comment_params)
    book_comment.book_id=@book.id
    book_comment.save
    # 非同期通信　create.js.erbを表示するので変数記載（booksコントローラと同じでOK）
    @book_comment=BookComment.new
    # redirect_back(fallback_location: root_path)
  end

  def destroy
    BookComment.find_by(id:params[:id]).destroy
    # redirect_back(fallback_location: root_path)
    # 非同期通信　create.js.erbを表示するので変数記載
    @book=Book.find(params[:book_id])
    @book_comment=BookComment.new
  end

  private
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

  # destroyは本人のみ
  def ensure_correct_user
    @book=BookComment.find_by(id:params[:id])
    unless @book.user == current_user
      redirect_back(fallback_location: root_path)
    end
  end

end
