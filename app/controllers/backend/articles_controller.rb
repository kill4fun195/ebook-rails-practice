class  Backend::ArticlesController < ApplicationController
  load_and_authorize_resource
  layout "backend"
  def index
    if current_user.has_role? :member
      @grid = GridArticlesGrid.new(params[:grid_articles_grid]) do |scope|
        scope.where(user_id: current_user.id).page(params[:page]).per_page(5)
      end
    end

    if current_user.has_role? :admin
      @grid = GridArticlesGrid.new(params[:grid_articles_grid]) do |scope|
        scope.page(params[:page]).per_page(5)
      end
    end

    if current_user.has_role? :editor
      @grid = GridArticlesGrid.new(params[:grid_articles_grid]) do |scope|
        scope.page(params[:page]).per_page(5)
      end
    end

  end 
  
  def new
    @article = Article.new
    @categories = Category.all
  end

  def edit
    @article = Article.find(params[:id])
    @categories = Category.all
    @category_ids = @article.categories.ids
  end

  def create 
    @article = current_user.articles.create(article_params)
    if @article.errors.empty?
      category_ids = params[:category_id]
      category_ids.each do |cat_id|
      @article.category_articles.create(category_id: cat_id)
      end
    end
    redirect_to backend_article_path(@article.id)
  end

  def show
    @article = Article.find(params[:id])
     @session = User.new
    if current_user
      flash.now.notice = "logged"
    else
      flash.now.notice = "invalid"
    end
    @comments = @article.comments.order_desc.page(params[:page]).per_page(10)
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
    redirect_to backend_articles_path
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to backend_articles_path
  end
  private 
  def article_params
    params.require(:article).permit(:title,:details,:description,:avatar,:linkdownload,:weight)
  end
 
end
