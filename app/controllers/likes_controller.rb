class LikesController < ApplicationController
  def create
    @like = Like.new
    @like.author_id = current_user.id
    @like.post_id = params[:post_id]
    if @like.save
      flash[:notice] = 'Like added successfully'
    else
      flash.now[:error] = 'Like not added'
    end
    redirect_to "/users/#{current_user.id}/posts"
  end
end
