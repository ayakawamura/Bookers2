class FavoritesController < ApplicationController
  def create
    # 非同期通信でviewで使う用にインスタンス変数にする
    @book=Book.find(params[:book_id])
    favorite=current_user.favorites.new(book_id: @book.id)
    favorite.save
    # redirect_back(fallback_location: root_path) 
  end

  def destroy
    # 非同期通信でviewで使う用にインスタンス変数にする
    @book=Book.find(params[:book_id])
    favorite=current_user.favorites.find_by(book_id: @book.id)
    favorite.destroy
    # redirect_back(fallback_location: root_path)
  end
end
