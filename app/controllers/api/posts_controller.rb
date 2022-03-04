class Api::PostsController < ApplicationController
  def index
    if request.headers['X-AUTH-TOKEN']
      @user = User.find_by_api_token(request.headers['X-AUTH-TOKEN'])
      @posts = Post.where(user_id: @user.id)
      respond_to do |format|
        format.json { render json: @posts, status: :ok }
      end
    else
      respond_to do |format|
        format.json { render json: 'please sign in or add the token', status: :ok }
      end
    end
  end
end
