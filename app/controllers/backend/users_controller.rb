class  Backend::UsersController < ApplicationController
  load_and_authorize_resource
  layout "backend"
  def index
      @grid = GridUsersGrid.new(params[:grid_users_grid]) do |scope|
      scope.page(params[:page]).per_page(10)
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user =  User.find(params[:id])
  end

  def update_image
    @user =  User.find(params[:id])
    @user.update(:avatar_user => params["user"]["avatar_user"])
    redirect_to backend_users_path
  end

  def update
   @user = User.find(params[:id])
   if @user.update_password_with_password(user_params)
    # Sign in the user by passing validation in case their password changed
    sign_in @user, :bypass => true
    redirect_to backend_users_path
   else
    render "edit"
  end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to backend_users_path
  end

  private

    def user_params
      params.require(:user).permit(:current_password,:name_user,:email, :password, :password_confirmation)
    end
end
