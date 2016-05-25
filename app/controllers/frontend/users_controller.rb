class Frontend::UsersController < ApplicationController
  layout "application"
  skip_before_action :require_login, only: [:new,:create] 
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save 
     session[:user_id] = @user.id 
     @user.add_role :member
     redirect_to root_path
    else
      redirect_to new_backend_user_path
    end
  end
  private

  def user_params
    params.require(:user).permit(:name_user,:password,:email)
  end
end
