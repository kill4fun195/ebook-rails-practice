class FrontendsController < ApplicationController
  skip_before_action :require_login

  layout "frontend"

  def index
    if params[:search]
      @articles = Article.includes(:categories,:comments).order_desc.search(params[:search]).page(params[:page]).per_page(5)
    else
      @articles = Article.includes(:categories,:comments).order_desc.page(params[:page]).per_page(5)
    end
    @a = params[:page].to_i 
    if (@articles.count % 2 == 0 )
      @t = (@articles.count / 5) 
    else
      @t = (@articles.count / 5) + 1
    end

  end
end
