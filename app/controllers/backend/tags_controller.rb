class  Backend::TagsController < ApplicationController
  load_and_authorize_resource
  layout "backend"
  def index
    @categories = Tag.all
     @grid = GridTagsGrid.new(params[:grid_tags_grid]) do |scope|
      scope.page(params[:page]).per_page(15)
    end
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.create(tag_params)

    redirect_to backend_tag_path(@tag.id)
  end

  def show
    @tag = Tag.find(params[:id])
    @articles = @tag.articles.page(params[:page]).per_page(3).order_desc
    @a = params[:page].to_i 
    @t = (@tag.articles.count / 3) 
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])
    @tag.update(tag_params)
    redirect_to backend_tags_path
  end

  def destroy
    @tag = tag.find(params[:id])
    @tag.destroy
    redirect_to backend_tags_path
  end

  private
  def tag_params
    params.require(:tag).permit(:name_tag)
  end
end
