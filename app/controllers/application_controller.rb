class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user
  before_action :require_login
  before_action :initial_sidebar

  private

    def current_user
      @current_user ||= session[:user_id] && User.find(session[:user_id])
    end

    def require_login
      if current_user.blank?
        redirect_to new_session_path
      end
    end 
    def initial_sidebar
      @popular_post = Article.includes(:comments,:categories).order(viewer: :desc).limit(10)
      @new_post = Article.includes(:comments,:categories).order_desc.limit(10)
      @new_comment = Comment.includes(:user,:article).order_desc.limit(10)
      @categories = Category.includes(:articles).all
    end 

end
