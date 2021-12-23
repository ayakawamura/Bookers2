class BookCommentsController < ApplicationController
  before_action :ensure_correct_user, only: [:destroy]

  def create
    @book=Book.find(params[:book_id])
    book_comment=BookComment.new(book_comment_params)
    book_comment.user_id=current_user.id
    book_comment.book_id=@book.id
    book_comment.save
  end

  def destroy
    # BookComment.find_by(id:params[:id]).destroy　下記3行に書き換え
    book=Book.find(params[:book_id])
    book_comment=book.book_comments.find(params[:id])
    book_comment.destroy
    # redirect_back(fallback_location: root_path)
    # 非同期通信　create.js.erbを表示するので変数記載
    @book=Book.find(params[:book_id])
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
