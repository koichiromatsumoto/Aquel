class AlbumsController < ApplicationController
  before_action :authenticate_user!, only:[:create, :destroy]

  def index
  	@albums = Album.all.order(created_at: :desc)
  	@album = Album.new
		respond_to do |format|
		  format.html
		  format.js
	  end
  end

  def show
    @album = Album.find(params[:id])
    @albums = Album.where(user_id: @album.user.id).order(created_at: :desc)
  end

  def create
  	@albums = Album.all.order(created_at: :desc)
  	@album = Album.new(album_params)
  	@album.user_id = current_user.id
    @post = Post.find(session[:post_id].to_i)
  	if @album.save
	  	respond_to do |format|
	      format.html
	      format.js
	    end
      session[:post_id] = nil
  	else
      flash[:danger] = "アルバム名は1〜20文字で入力してください"
  		redirect_to post_path(@post.id)
  	end
  end

  def destroy
    @album = Album.find(params[:id])
    if @album.destroy
      flash[:success] = "アルバムを削除しました"
      redirect_to user_path(current_user.id)
    else
      flash.now[:danger] = "アルバムの削除に失敗しました"
      render :show
    end
  end

  private
  def album_params
  	params.require(:album).permit(:name, :user_id, {post_ids:[]})
  end
end
