class PostsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create, :edit, :update, :destroy, :album_in, :album_out, :hashtag]

  def top
    @late_posts = Post.order(created_at: :desc).all
    @trend_posts = Post.where(created_at: Time.now.beginning_of_month..Time.now.end_of_month).order("favorites_count" => :desc).all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if params[:back]
      render :new
    elsif @post.save
      flash[:success] = '投稿しました'
      redirect_to post_path(@post.id)
    else
      render :new
    end
  end

  def index
    @late_posts = Post.order(created_at: :desc).page(params[:late_page]).per(12)
    @trend_posts = Post.where(created_at: Time.now.beginning_of_month..Time.now.end_of_month).order("favorites_count" => :desc).page(params[:trend_page]).per(12)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def search_result
    @search_late_posts = @search.result(distinct: true).order(created_at: :desc).page(params[:search_late_page]).per(12)
    @search_trend_posts = @search.result(distinct: true).where(created_at: Time.now.beginning_of_month..Time.now.end_of_month).order("favorites_count" => :desc).page(params[:search_trend_page]).per(12)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @post = Post.find(params[:id])
    @albums = Album.all.order(created_at: :desc)
    @album = Album.new
    session[:post_id] = params[:id]
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.user = current_user
      if @post.update(post_params)
        flash[:success] = '投稿を編集しました'
        redirect_to post_path(@post.id)
      else
        render :edit
      end
    else
      render :show
    end
  end

  def destroy
    post = Post.find(params[:id])
    if post.user = current_user
      post.destroy
      flash[:success] = '投稿を削除しました'
      redirect_to posts_path
    else
      render :show
    end
  end

  def album_in
    @post = Post.find(params[:id])
    @album = Album.find(params[:album_id])

    if @album.user = current_user
      unless @album.posts.include?(@post)
        @postalbum = PostAlbum.create(album_id: @album.id, post_id: @post.id)
        flash[:success] = 'アルバムに追加しました'
        redirect_to album_path(@album.id)
      else
        flash.now[:danger] = 'すでに追加されています'
        render :show, id: params[:id]
      end
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
      flash[:success] = 'アルバムから削除しました'
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
