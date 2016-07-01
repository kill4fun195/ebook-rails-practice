class Frontend::ArticlesController < ApplicationController
  skip_before_action :require_login
  layout "frontend"
  def index
     @articles = Article.all.select(:id, :title).where("lower(title) like ?", "%#{params[:query].to_s.downcase}%")
     respond_to do |format|
    format.html # render index.html
    format.json { render :json => @articles.pluck(:title) }
     end
  end
  def show
    
     @session = User.new
    if current_user
      flash.now.notice = "logged"
    else
      flash.now.notice = "invalid"
    end
    @article = Article.friendly.find(params[:id])
    @comments = @article.comments.order_desc.page(params[:page]).per_page(10)
    a = @article.viewer.to_i + 1
    @article.update(viewer: a)
    
  end
 
end
