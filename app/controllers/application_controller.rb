class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search
	protect_from_forgery with: :exception


  # ログイン後にマイページへ遷移
  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def  set_search
    @search = Post.includes(:hashtags).ransack(params[:q])
    @search_late_posts = @search.result(distinct: true).order(id: :desc).all
    @search_trend_posts = @search.result(distinct: true).order('post_favorites_count' => 'DESC').all
  end
end
