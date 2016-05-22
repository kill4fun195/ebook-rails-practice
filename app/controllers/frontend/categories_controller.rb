class Frontend::CategoriesController < ApplicationController
  skip_before_action :require_login
  layout "frontend"
  def show
    @category = Category.friendly.find(params[:id])
    @articles = @category.articles.page(params[:page]).per_page(5).order_desc
    @a = params[:page].to_i 
    if (@category.articles.count % 2 == 0 )
      @t = (@category.articles.count / 5) 
    else
      @t = (@category.articles.count / 5) + 1
    end

  end
  
end
