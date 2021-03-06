class PostsController < ApplicationController
  def index
    @author = User.find(params[:user_id])
    @posts = @author.posts.includes(:comments)
  end

  def show
    @post = Post.find(params[:id])
    @author = @post.author
  end

  def new
    @post = Post.new
  end

  def create
    new_post = current_user.posts.new(params.require(:post).permit(:title, :text))
    new_post.likes_counter = 0
    new_post.comments_counter = 0
    respond_to do |format|
      format.html do
        if new_post.save
          redirect_to "/users/#{new_post.author.id}/posts/", notice: 'Post created successfully'
        else
          render :new, alert: 'Sorry something went wrong'
        end
      end
    end
  end

  def destroy
    post = Post.find(params[:id])
    user = User.find(post.user_id)
    user.posts_counter -= 1
    post.destroy
    user.save
    flash[:success] = 'You have deleted this post successfully!'
    redirect_to user_path(current_user.id)
  end
end
