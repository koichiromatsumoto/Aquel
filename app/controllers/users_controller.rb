class UsersController < ApplicationController
  before_action :correct_user, only:[:edit, :update, :withdraw]
  before_action :require_admin, only:[:index, :admin]


  def show
    @user = User.find(params[:id])
    @current_user = User.find(current_user.id)
    @follow_users = @current_user.following.all
    @timeline_posts = Post.where(user_id: @follow_users).order(created_at: :desc)
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

  def correct_user
    if user_signed_in?
      user = User.find(params[:id])
      if user != current_user && current_user.admin == false
        redirect_to user_path(current_user.id)
      end
    else
      redirect_to root_path
    end
  end

  def require_admin
    if user_signed_in?
      if current_user.admin == false
        redirect_to user_path(current_user.id)
      end
    else
      redirect_to root_path
    end
  end
end
