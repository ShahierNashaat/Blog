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

  def destroy
    @comment = Comment.find(params[:comment_id])
    @post = Post.find(@comment.post_id)
    @post.comments_counter -= 1
    @comment.destroy!
    @post.save
    flash[:success] = 'You have deleted this comment successfully!'
    redirect_to user_post_path(current_user.id, @comment.post_id)
  end
end
