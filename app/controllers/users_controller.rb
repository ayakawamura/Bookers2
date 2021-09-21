class UsersController < ApplicationController

  # 他人のアカウント編集ができなくなる
  #before_action :signed_in_user,only:[:edit,:update]
  #before_action :correct_user,only:[:edit,:update]

  def index
    @users=User.all
    @newbook=Book.new
    @user=User.find(current_user.id)
  end

  def show
    @user=User.find(params[:id])
    @newbook=Book.new
    @books=@user.books
  end

  def edit
    @user=User.find(params[:id])
    if @user == current_user
      render :edit
    else
      redirect_to user_path(current_user
      )
    end
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

  private
  def user_params
    params.require(:user).permit(:name,:profile_image,:introduction)
  end

  # def correct_user
  #   @user=User.find(params[:id])
  #   redirect_to user_path(@user.id),notice:"Please"unless current_user?(@user)
  # end


end
