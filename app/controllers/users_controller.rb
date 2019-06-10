class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def mypage
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       redirect_to user_path(@user.id)
    end
  end

  def index
    @users = User.all
  end

  def withdraw_view
  end

  def withdraw
    current_user.update(status: false)
    flash[:danger] = '退会しました'
    redirect_to root_path
  end

  def admin
    user = User.find(params[:id])
    if user.admin == false
      user.update(admin: true)
      redirect_to users_path
    else
      user.update(admin: false)
      redirect_to users_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :password, :password_confirmation, :email, :status, :admin)
  end
end
