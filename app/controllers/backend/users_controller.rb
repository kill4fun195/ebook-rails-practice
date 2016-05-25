class Backend::UsersController < ApplicationController
  load_and_authorize_resource
  layout "backend"
  skip_before_action :require_login, only: [:new,:create]
  def index
    @users = User.all
     @grid = GridUsersGrid.new(params[:grid_users_grid]) do |scope|
      scope.page(params[:page]).per_page(20)
    end
  end
  
  def new
    @user = User.new
    render :layout => "application"
  end

  def edit
    @user = User.find(params[:id])
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

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to backend_users_path
  end
  
  def destroy
    @user = User.find(params[:id]).destroy
    redirect_to backend_users_path
  end

  private

  def user_params
    params.require(:user).permit(:name_user,:password,:email)
  end
end
