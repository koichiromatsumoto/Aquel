class PostsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create, :edit, :update, :destroy, :album_in, :album_out, :hashtag]


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
    @posts = Post.all
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
    if post.user = current_user
      post.update(post_params)
      redirect_to post_path(post.id)
    else
      render :show
    end
  end

  def destroy
    post = Post.find(params[:id])
    if post.user = current_user
      post.destroy
      redirect_to posts_path
    else
      render :show
    end
  end

  def album_in
    @post = Post.find(params[:id])
    @album = Album.find(params[:album_id])

    if @album.user = current_user
      @postalbum = PostAlbum.create(album_id: @album.id, post_id: @post.id)
      redirect_to album_path(@album.id)
    else
      render :show, id: params[:id]
    end
  end

  def album_out
    @album = Album.find(params[:album_id])
    @post = Post.find(params[:id])
    if @album.user = current_user
      @postalbum = PostAlbum.find_by(album_id: @album.id, post_id: @post.id)
      @postalbum.destroy
      redirect_to album_path(@album.id)
    else
      render 'albums/show', id: params[:album_id]
    end
  end

  def hashtag
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :post_image, :title, :text, {album_ids:[]})
  end
end
