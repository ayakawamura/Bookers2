class UsersController < ApplicationController

  def index
    @users=User.all
    @book=Book.new
    @user=User.find(current_user.id)
  end

  def show
    @user=User.find(params[:id])
    @book=Book.new
    @books=@user.books
  end

  def edit
    @user=User.find(params[:id])
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


end
