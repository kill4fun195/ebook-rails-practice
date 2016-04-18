class ArticlesController < ApplicationController
  layout "frontend" , only: [:show]
  skip_before_action :require_login, only: [:show]

  def index
    if current_user.role == "admin"
      @articles = Article.all
    else
      @articles = current_user.articles
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
    redirect_to article_path(@article)
  end

  def show
    @article = Article.find(params[:id])
    @comments = @article.comments.all
    a = @article.viewer.to_i + 1
    @article.update(viewer: a)
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
    params.require(:article).permit(:title,:details,:description)
  end
 
end
