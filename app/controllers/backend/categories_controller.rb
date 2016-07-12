class Backend::CategoriesController < ApplicationController
  load_and_authorize_resource
  layout "backend"

  def index
    @categories = Category.all
     @grid = GridCategoriesGrid.new(params[:grid_categories_grid]) do |scope|
      scope.page(params[:page]).per_page(15)
    end
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.create(category_params)

    redirect_to backend_category_path(@category.id)
  end

  def show
    @category = Category.find(params[:id])
    @articles = @category.articles.page(params[:page]).per_page(3).order_desc
    @a = params[:page].to_i 
    @t = (@category.articles.count / 3) 
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    @category.update(category_params)
    redirect_to backend_categories_path
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to backend_categories_path
  end

  private
  def category_params
    params.require(:category).permit(:name_category)
  end
end
