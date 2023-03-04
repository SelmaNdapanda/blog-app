class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      format.html do
        if @post.save
          flash[:success] = 'Post was successfully created.'
          redirect_to user_post_path(current_user, @post)
        else
          flash.now[:error] = 'Post was not created.'
          render :new
        end
      end
    end
  end

  private

  def post_params
    params.require(:new_post).permit(:title, :text)
  end
end
