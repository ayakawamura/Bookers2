class RoomsController < ApplicationController

  def create
    @room = Room.create
    # current_userのEntry
    @entry1=Entry.create(room_id: @room.id ,user_id: current_user.id)
    # DMを受け取る側のEntry(User_idはusers/showで渡しているので、room_idを拾って、マージしている)
    @entry2=Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id))
    redirect_to room_path(@room.id)
  end

  def show
    @room =Room.find(params[:id])
    # entriesテーブルにcurrent_user.idと紐付いたチャットルームがあるかどうか確認
    if Entry.where(user_id: current_user.id,room_id: @room.id).present?
      @messages = @room.messages
      @message = Message.new
      # チャットルームのユーザ情報を表示させるため代入
      @entries = @room.users
      
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private
    def entry_params
      params.permit(:user_id, :room_id)
      # params.require(:entry).permit(:user_id, :room_id)とするとエラーになる
  end
  
  # def create
  #   @user = User.find(params[:id])
  #   @room = Room.new
  #   @room.save
  #   # #@room.idとcurrent_user.idをentryのカラムに保存(１レコード)
  #   entry.create(room_id: @room.id ,user_id: current_user.id)
  #   entry.create(room_id: @room.id ,user_id: @user.id)
  #   redirect_to :show
  # end


  # def show
  #   @user = User.find(params[:id])
  #   # current_userがuser_idとして登録されてるentryテーブルから、room_idを取得（複数）
  #   roomIds = current_user.entries.pluck(:room_id)
  #   #user_idが@user　且つ　room_idが上で取得したrooms配列の中にある数値のもののみ取得
  #   entry = Entry.find_by(user_id: @user.id,room_id: roomIds)
    
  #   if entry.nil? #上記で取得できなかった場合の処理
  #     @room = Room.new
  #     @room.save
  #     # #@room.idとcurrent_user.idをentryのカラムに保存(１レコード)
  #     entry.create(room_id: @room.id ,user_id: current_user.id)
  #     entry.create(room_id: @room.id ,user_id: @user.id)
  #   else
  #   # 上で取得した@entryに紐づいてるroomテーブルを取得
  #     @room = entry.room
  #   end

  #   @messages = @room.messages
  #   @message = Message.new

  # end

end
