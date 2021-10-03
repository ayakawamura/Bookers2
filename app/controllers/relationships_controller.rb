class RelationshipsController < ApplicationController
	
	def create
		# relationshipsはIDが無い
		@user=User.find(params[:user_id])
		#＠userがusermodel/follow/other_user.idに入る 
		current_user.follow(@user)
		redirect_back(fallback_location: root_path)
	end

  def destroy
    @user=User.find(params[:user_id])
  	current_user.unfollow(@user)
    redirect_back(fallback_location: root_path)
  	# redirect_to request.referer
  end
  
  def following
    @user=User.find(params[:user_id])
    @users=@user.following_user
  end
  
  def followers
    @user=User.find(params[:user_id])
    @users=@user.follower_user
  end

end
