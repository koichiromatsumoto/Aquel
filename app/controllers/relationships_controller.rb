class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find(params[:followed_id])
    if current_user.follow(user)
      flash[:success] = 'ユーザーをフォローしました'
      redirect_to user_path(current_user.id)
    else
      flash.now[:alert] = 'ユーザーのフォローに失敗しました'
      redirect_to user_path(user.id)
    end
  end

  def destroy
    user = Relationship.find(params[:id]).followed
    if current_user.unfollow(user)
      flash[:success] = 'ユーザーのフォローを解除しました'
      redirect_to user_path(current_user.id)
    else
      flash.now[:alert] = 'ユーザーのフォロー解除に失敗しました'
      redirect_to user_path(user.id)
    end
  end
end
