class CategoriesController < ApplicationController
  layout "frontend" , only:[:show]
  before_action :check_role , only: [:index,:new,:edit]
  skip_before_action :require_login ,only: [:show]
  def index
    @categories = Category.all
  end
  def new
    @category = Category.new
  end
  def create
    @category = Category.create(category_params)

    redirect_to category_path(@category)
  end
  def show
    @category = Category.find(params[:id])
    @articles = @category.articles.all
     i = 5
        n = @category.articles.count
        if (n % i == 0)
          @t = n/i
        else
          @t = n/i + 1
        end
        @a = params[:page].to_i 
        @c = @a - 1
        @q = @c*i
  end
  def edit
    @category = Category.find(params[:id])
  end
  def update
    @category = Category.find(params[:id])
    @category.update(category_params)
    redirect_to categories_path
  end
  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path
  end
  private
  def category_params
    params.require(:category).permit(:name_category)
  end
  def check_role
    if current_user.role != "admin"
      redirect_to sessions_path, notice: "You do not access this page , you are not admin!!!"
    end
  end
end
