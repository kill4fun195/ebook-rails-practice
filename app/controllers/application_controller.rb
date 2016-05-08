class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user
  before_action :require_login

  private

    def current_user
      @current_user ||= session[:user_id] && User.find(session[:user_id])
    end

    def require_login
      if current_user.blank?
        redirect_to new_session_path
      end
    end  
end
