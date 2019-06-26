class UsersController < ApplicationController
  # カレントユーザとアドミンのみ可能なアクション
  before_action :correct_user, only:[:edit, :update, :withdraw]
  # アドミンのみ可能なアクション
  before_action :require_admin, only:[:index, :admin, :admin_show]


  def show
    @user = User.find(params[:id])
    @albums = Album.where(user_id: @user.id).all
    if @user.admin == false
      if @user == current_user
        @current_user = User.find(current_user.id)
        @follow_users = @current_user.following.all
        @timeline_posts = Post.where(user_id: @follow_users).order(created_at: :desc)
      end
    else
      if current_user.admin == true
        redirect_to user_admin_show_path
      else
        redirect_to user_path(current_user.id)
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
      flash[:success] = 'ユーザ情報を編集しました'
    else
      @user.errors.full_messages.each do |msg|
        flash[:danger] = msg
      end
      redirect_to user_path(@user.id)
    end
  end

  def index
    @users = User.page(params[:page]).per(20)
  end

  def withdraw
    if current_user.update(status: false)
      flash[:danger] = '退会しました'
      redirect_to root_path
    else
      flash[:danger] = "退会に失敗しました"
      render :withdraw
    end
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

  def admin_show
    @unreplied_contacts = Contact.where(reply: nil).all
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
