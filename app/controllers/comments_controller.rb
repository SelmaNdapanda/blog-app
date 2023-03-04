class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    @comment.post_id = params[:post_id]
    if @comment.save
      flash[:success] = 'Comment added successfully'
      redirect_to user_post_path(params[:user_id], params[:post_id])
    else
      flash.now[:error] = 'Comment not added'
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
