class PostsController < ApplicationController
  def new
    @post = Post.new
    @categories = Category.all
  end

  def confirm
    @post = Post.new(post_params)
    @categories = Category.all
    session[:post_info] = @post

  end

  def create
    @post = Post.new(session[:post_info])
    @post.user_id = current_user.id
    if params[:back]
      render :new
    elsif @post.save
      redirect_to user_path(current_user.id)
    else
      render :new
    end
    session[:post_info] = nil
    session[:post_image] = nil
    session[:post_categories] = nil
  end

  def index
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def hashtag
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :post_image, :title, :text, category_ids:[])
  end
end
