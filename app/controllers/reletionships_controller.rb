class ReletionshipsController < ApplicationController

	def create
		#@user=User.find(params[:id])
		current_user.follow(params[:id])
		#following = current_user.new(follower_id:user.id)
		redirect_back(fallback_location: root_path)
	end

	def follower
	
	end

  def followed
  end

  def destroy
  	current_user.unfollow(params[:id])
  	redirect_back(fallback_location: root_path)
  end

end
