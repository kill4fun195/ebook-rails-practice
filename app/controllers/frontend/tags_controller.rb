class  Frontend::TagsController < ApplicationController
  layout "frontend"
  def show
    @tag = Tag.friendly.find(params[:id])
    @articles = @tag.articles.page(params[:page]).per_page(5).order_desc
    @a = params[:page].to_i 
    if (@tag.articles.count % 2 == 0 )
      @t = (@tag.articles.count / 5) 
    else
      @t = (@tag.articles.count / 5) + 1
    end

  end
end
