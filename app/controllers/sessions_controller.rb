class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]


  def new
    if current_user 
      redirect_to sessions_path, :notice => "Logged in!"
    end
    @session = User.new

  end
  
  def create
    user = User.find_by_email(user_params[:email])
    if user && user.authenticate(user_params[:password])
      session[:user_id] = user.id
      flash.now.notice = "Logged in success!!"
      redirect_to(:back)
    else
      @session = User.new
      flash.now.notice = "Invalid email or password"
      redirect_to(:back)
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to  root_path, :notice => "Logged out!"
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
