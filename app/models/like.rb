class Like < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :user_id
  belongs_to :post

  after_save :update_likes_counter

  private

  def update_likes_counter
    likes_number = Like.where(post: post).count('id')
    post.update(likes_counter: likes_number)
  end
end
