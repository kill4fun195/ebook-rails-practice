class UsersController < ApplicationController
  before_action :check_role

  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end
  def edit
    @user = User.find(params[:id])
  end
  def create
    @user = User.create(user_params)
    redirect_to user_path(@user)
  end
  def show
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to users_path
  end
  def destroy
    @user = User.find(params[:id]).destroy
    redirect_to users_path
  end

  private

  def check_role
    if current_user.role != "admin"
      redirect_to sessions_path, notice: "You do not access this page , because you are not admin !!!"
    end
  end

  def user_params
    params.require(:user).permit(:name_user,:role,:password,:email)
  end
end
