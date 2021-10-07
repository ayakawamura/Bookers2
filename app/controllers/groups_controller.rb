class GroupsController < ApplicationController
	
	before_action :ensure_correct_user,only:[:edit,:update]
	before_action :correct_user,only:[:groupdelete]


	def index
		@user = current_user
		@newbook = Book.new
		@groups = Group.all
	end

	def show
		@user = current_user
		@newbook = Book.new
		@group = Group.find(params[:id])
	end

	def new
		@group = Group.new
	end

	def create
		@group = Group.new(group_params)
		@group.owner_id = current_user.id
		@group.users << current_user
		if @group.save
			redirect_to groups_path ,notice:"新しいグループを作成しました"
		else
			render :new
		end
	end
	
	def edit
		@group = Group.find(params[:id])
	end
	
	def update
		@group = Group.find(params[:id])
		if @group.update(group_params)
			redirect_to groups_path ,notice:"グループを更新しました"
		else
			render :edit 
		end
	end
	
	def join
		@group = Group.find(params[:group_id])
		@group.users << current_user
		redirect_to groups_path
	end
	
	def destroy
		@group = Group.find(params[:id])
		@group.users.destroy(current_user)
		redirect_to groups_path
	end
	
	def groupdelete
		group = Group.find(params[:group_id])
		group.destroy
		redirect_to groups_path
	end
	
	private
	def group_params
		params.require(:group).permit(:name,:image,:introduction)
	end
	
	def ensure_correct_user
		@group = Group.find(params[:id])
		unless current_user.id == @group.owner_id
			redirect_to groups_path
		end
	end
	
	def correct_user
		group = Group.find(params[:group_id])
		unless current_user.id == group.owner_id
			redirect_to groups_path
		end
	end
		
end
