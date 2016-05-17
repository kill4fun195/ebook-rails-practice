class ArticlesController < ApplicationController
  skip_before_action :require_login, only: [:show]

  def index
    if current_user.role == "admin"
      @articles = Article.order_desc

    else
      @articles = current_user.articles.order_desc
    end
     @grid = GridArticlesGrid.new(params[:grid_articles_grid]) do |scope|
      scope.page(params[:page]).per_page(5)
    end
    render :layout => 'backend'
  end

  def new
    @article = Article.new
    @categories = Category.all
    render :layout => 'backend'
  end

  def edit
    @article = Article.find(params[:id])
    @categories = Category.all
    @category_ids = @article.categories.ids
    render :layout => 'backend'
  end

  def create 
    @article = current_user.articles.create(article_params)
    if @article.errors.empty?
      category_ids = params[:category_id]
      category_ids.each do |cat_id|
      @article.category_articles.create(category_id: cat_id)
      end
    end
    redirect_to article_path(@article)
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
    
    render :layout => 'frontend'
  end
  def update
    @article = Article.find(params[:id])
    @article.update(article_params)
    @article.category_articles.destroy_all
    if @article.errors.empty?
      category_ids = params[:category_id]
      category_ids.each do |c|
        @article.category_articles.create(category_id: c)
      end
    end
    redirect_to articles_path
  end
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end
  private 
  def article_params
    params.require(:article).permit(:title,:details,:description,:avatar,:linkdownload,:weight)
  end
 
end
