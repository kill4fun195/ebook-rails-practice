class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :initial_sidebar
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name_user])
  end

  private

    def initial_sidebar
      @popular_post = Article.includes(:comments,:categories).order(viewer: :desc).limit(10)
      @new_post = Article.includes(:comments,:categories).order_desc.limit(10)
      @new_comment = Comment.includes(:user,:article).order_desc.limit(10)
      @categories = Category.includes(:articles).all
    end 

end
