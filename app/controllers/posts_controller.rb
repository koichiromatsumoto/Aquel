class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if params[:back]
      render :new
    elsif @post.save
      redirect_to post_path(@post.id)
    else
      render :new
    end
  end

  def index
    post_favorites_count = Post.joins(:favorites).group('post_id').count
    @late_posts = Post.all.order(created_at: :desc)
    @trend_posts = Post.all.order('post_favorites_count' => 'DESC')
  end

  def search_result
    @search_late_posts = @search.result(distinct: true).order(created_at: :desc)
    @search_trend_posts = @search.result(distinct: true).order('post_favorites_count' => 'DESC')
  end

  def show
    @post = Post.find(params[:id])
    @albums = Album.all.order(created_at: :desc)
    @album = Album.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
    redirect_to post_path(post.id)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  def album_in
    @album = Album.find(params[:album_id])
    @post = Post.find(params[:id])
    @postalbum = PostAlbum.create(album_id: @album.id, post_id: @post.id)
    redirect_to album_path(@album.id)
  end

  def album_out
    @album = Album.find(params[:album_id])
    @post = Post.find(params[:id])
    @postalbum = PostAlbum.find_by(album_id: @album.id, post_id: @post.id)
    @postalbum.destroy
    redirect_to album_path(@album.id)
  end

  def hashtag
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :post_image, :title, :text, {album_ids:[]})
  end
end
