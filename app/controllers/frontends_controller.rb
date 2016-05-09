class FrontendsController < ApplicationController
  skip_before_action :require_login

  layout "frontend"

  def index
    if params[:search]
      @articles = Article.includes(:categories,:comments).search(params[:search]).order_desc
    else
      @articles = Article.includes(:categories,:comments).order_desc
    end
      
    i = 5
    n = @articles.count
    if (n % i == 0)
      @t = n/i
    else
      @t = n/i + 1
    end
    @a = params[:page].to_i 
    @c = @a - 1
    @q = @c*i

  end 

end
