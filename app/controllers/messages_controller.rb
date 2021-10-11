class MessagesController < ApplicationController
	
	def create
		# メッセージフォームから送られてきたroom_idとcurrent_user.idを持ったデータがEntryにあるか確認
	  if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
		# contentとroom_idはformで送られてきている
		# user_idをマージして新規メッセージを作成
		if @message = Message.create((message_params).merge(user_id: current_user.id))
		redirect_back(fallback_location: root_path)
		else
	  	  flash[:alert]="メッセージ送信に失敗しました"
		  redirect_back(fallback_location: root_path)
		end
	  end
	end

	private
	def message_params
		params.require(:message).permit(:content,:user_id,:room_id)
	end

end
