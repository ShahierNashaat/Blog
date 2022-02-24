class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    new_comment = current_user.comments.new(params.require(:comment).permit(:text))
    new_comment.post_id = @post.id
    if new_comment.save
      redirect_to "/users/#{@post.user_id}/posts/#{@post.id}", notice: 'Comment created successfully'
    else
      redirect_to "/users/#{@post.user_id}/posts/#{@post.id}", alert: 'Sorry something went wrong'
    end
  end
end
