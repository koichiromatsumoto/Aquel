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
    @late_posts = Post.all.order(created_at: 'DESC')
    @trend_posts = Post.all.order('post_favorites_count' => 'DESC')
  end

  def search_result
    @search_late_posts = @search.result(distinct: true).order(id: :desc)
    @search_trend_posts = @search.result(distinct: true).order('post_favorites_count' => 'DESC')
  end

  def show
    @post = Post.find(params[:id])
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
  end

  def hashtag
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :post_image, :title, :text)
  end
end
