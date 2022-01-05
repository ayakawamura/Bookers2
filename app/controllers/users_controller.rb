class UsersController < ApplicationController
  # 他人のアカウント編集ができなくなる
  # before_action :signed_in_user,only:[:edit,:update]
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @users = User.all
    @newbook = Book.new
    @user = User.find(current_user.id)
  end

  def show
    @user = User.find(params[:id])
    @newbook = Book.new
    @books = @user.books
    @today_books = @books.created_today
    @yesterday_books = @books.created_yesterday
    @this_week_books = @books.created_this_week
    @last_week_books = @books.created_last_week

    # チャットボタン
    # entriesテーブルから、current_userがuser_idに入っているものを探す
    @current_UserEntry = Entry.where(user_id: current_user.id)
    # entriesテーブルから、DMを送る相手のidがuser_idに入ってるものを探す
    @userEntry = Entry.where(user_id: @user.id)

    # currentUserと@userのEntriesをそれぞれ一つずつ取り出し、2人のroomが既に存在するかを確認
    if @user.id != current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          # 2人のroomが既に存在していた場合
          if cu.room_id == u.room_id
            @isRoom = true
            # room_idを取り出す
            @roomId = cu.room_id
          end
        end
      end
      # 2人のroomが存在しない場合
      unless @isRoom
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:user_update] = "You have updated user successfully."
      redirect_to user_path(@user.id)
      # user#showページへ
    else
      render :edit
    end
  end

  def search
    user = User.find(params[:user_id])
    books = user.books
    @book = Book.new
    if params[:created_at] == ""
      @search_books = "日付を選択してください"
    else
      created_at = params[:created_at]
      @search_books = books.where(["created_at LIKE?", "#{created_at}%"]).count
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
