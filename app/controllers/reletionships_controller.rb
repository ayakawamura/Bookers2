class ReletionshipsController < ApplicationController

  def follow
	#@user=User.find(params[:relationship][:followed_id])
	current_user.follow(params[:id])
	redirect_to user_path(@user)
	#redirect_back(fallback_location: root_path)
  end

  def unfollow
  	#@user=Relationship.find(params[:id]).followed
  	current_user.unfollow(params[:id])
  	#redirect_back(fallback_location: root_path)
  	redirect_to root_path
  end

end
