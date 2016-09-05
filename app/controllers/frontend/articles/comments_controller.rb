class Frontend::Articles::CommentsController < ApplicationController
  def create
    @artile = Article.find(params[:article_id])
    @comment = @artile.comments.create(comment_params)
    redirect_to  article_path(@artile), notice: @comment.errors.full_messages.to_sentence
    byebug
  end

  private

  def comment_params
    params.require(:comment).permit(:body).tap do |p|
      p[:user_id] = current_user.id
    end
  end

end
