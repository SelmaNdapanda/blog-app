class PostsController < ApplicationController
  load_and_authorize_resource except: %i[index show]

  def index
    @user = User.find(params[:user_id])
    @posts = Post.includes(comments: [:author]).where(posts: { author_id: @user.id })

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    new_post = current_user.posts.new(post_params)

    respond_to do |format|
      format.html do
        if new_post.save
          redirect_to "/users/#{new_post.author_id}/posts/", notice: 'Post was successfully created.'
        else
          render :new, status: 'Error occured will creating post!'
        end
      end

      format.json { render json: @posts }
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.author.decrement!(:posts_counter)
    @post.destroy
    redirect_to "/users/#{current_user.id}/posts/", notice: 'Post was successfully deleted.'
  end

  private

  def post_params
    params.require(:new_post).permit(:title, :text)
  end

  def renderer(input)
    respond_to do |format|
      format.html
      format.xml { render xml: input }
      format.json { render json: input }
    end
  end
end
