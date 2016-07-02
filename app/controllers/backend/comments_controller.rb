class Backend::CommentsController < ApplicationController
  load_and_authorize_resource
  layout "backend"
  def index
    respond_to do |format|
    format.html
    format.json { render json: CommentDatatable.new(view_context, { user: current_user }) }
    end
  end

  def new 
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.create(comment_params)
    redirect_to comment_path(@comment)
  end

  def show
    @comment = Comment.find(params[:id])
    @approve = @comment.approve
  end

  def edit
    @comment = Comment.find(params[:id])
    render layout: false
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)
    respond_to do |format|
      format.html { redirect_to backend_comments_path }
      format.json do 
        render json: { comment: @comment.as_json(include: { article: { only: [:title] } }, only: [:id, :body]) } 
      end
    end
    
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to backend_comments_path
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :approve,:article_id)
  end
end
