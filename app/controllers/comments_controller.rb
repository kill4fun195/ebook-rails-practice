class CommentsController < ApplicationController
  def index
    if current_user.role == "admin"
     @comments = Comment.all
    else
      @comments = current_user.comments
    end
    @article_ids = Article.ids
    @user_ids = User.ids
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
  end
  def update
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)

    redirect_to comments_path
  end
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to comments_path
  end
  private
  def comment_params
    params.require(:comment).permit(:body,:approve,:article_id)
  end
end
