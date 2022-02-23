class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    unless Like.where(post_id: @post_id, user_id: current_user.id)
      new_like = current_user.likes.new
      new_like.post_id = @post.id
      new_like.save
    end
    redirect_to "/users/#{@post.user_id}/posts/#{@post.id}"
  end
end
