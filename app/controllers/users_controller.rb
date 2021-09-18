class UsersController < ApplicationController
  
  def index
    @users=User.all
    
  
  def show
    @user=User.find(params[:id])
  end

  def edit
    @user=User.find(params[:id])
  end
  
  def update
    @user=User.find(params[:id])
    @user=User.update(user_params)
    redirect_to user_path(@user.id)
    # user#showページへ
  end
  
  private
  def user_params
    params.require(:user).permit(:mane,:profile_image,:introduction)
  end
  
  
end
