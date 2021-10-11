class UsersController < ApplicationController

  # 他人のアカウント編集ができなくなる
  #before_action :signed_in_user,only:[:edit,:update]
  before_action :ensure_correct_user,only:[:edit,:update]

  def index
    @users=User.all
    @newbook=Book.new
    @user=User.find(current_user.id)
    
  end

  def show
    @user=User.find(params[:id])
    @newbook=Book.new
    @books=@user.books
    
    # チャットボタン
    # entriesテーブルから、current_userがuser_idに入っているものを探す
    @currentUserEntry = Entry.where(user_id: current_user.id)
    # entriesテーブルから、DMを送る相手のidがuser_idに入ってるものを探す
    @userEntry = Entry.where(user_id: @user.id)
    
    # currentUserと@userのEntriesをそれぞれ一つずつ取り出し、2人のroomが既に存在するかを確認
    if @user.id != current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          # 2人のroomが既に存在していた場合
          if cu.room_id == u.room_id
            @isRoom = true
            #room_idを取り出す
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
        
      
  # def show
  #   @user=User.find(params[:id])
  #   @newbook=Book.new
  #   @books=@user.books
  #   if @user.id != current_user.id
  #     # current_userがuser_idとして登録されてるentryテーブルから、room_idを取得（複数）
  #     roomIds = current_user.entries.pluck(:room_id)
  #     #user_idが@user　且つ　room_idが上で取得したrooms配列の中にある数値のもののみ取得
  #     entry = Entry.find_by(user_id: @user.id,room_id: roomIds)
      
  #     if entry.nil? #上記で取得できなかった場合の処理
  #       # roomとentryを新規作成する
  #       @room = Room.new
  #       @entry = Entry.new
  #     else
  #     # 上で取得したentryに紐づいてるroomテーブルを取得
  #       @room = entry.room
  #     end
  #   end
  # end

      
  def edit
    @user=User.find(params[:id])
    # if @user == current_user
    #   render :edit
    # else
    #   redirect_to user_path(current_user)
    # end
  end

  def update
    @user=User.find(params[:id])
    if @user.update(user_params)
      flash[:user_update]="You have updated user successfully."
      redirect_to user_path(@user.id)
      # user#showページへ
    else
      render :edit
    end
  end
  
# userコントローラーに一覧ベージを作る場合の記述
  # def following
  #   @user=User.find(params[:id])
  #   @users=@user.following_user
  # end
  
  # def followers
  #   @user=User.find(params[:id])
  #   @users=@user.follower_user
  # end
    
    
  private
  def user_params
    params.require(:user).permit(:name,:profile_image,:introduction)
  end

  def ensure_correct_user
    @user=User.find(params[:id])
    unless @user==current_user
    redirect_to user_path(current_user)
    end
  end


end
