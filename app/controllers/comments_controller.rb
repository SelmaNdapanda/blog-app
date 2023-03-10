class CommentsController < ApplicationController
  def index
    post = Post.includes(:comments).find(params[:post_id])

    respond_to do |format|
      format.html
      format.json { render json: post.comments }
    end
  end

  def new
    @comment = Comment.new

    respond_to do |format|
      format.html
      format.json { redirect_to new_user_post_comment_path(params[:user_id], params[:post_id]) }
    end
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

  def destroy
    @comment = Comment.find(params[:id])
    @comment.post.decrement!(:comments_counter)
    Comment.find(params[:id]).destroy
    redirect_to user_post_path(params[:user_id], params[:post_id]), notice: 'Comment was successfully deleted.'
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
