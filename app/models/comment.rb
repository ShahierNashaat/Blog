class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :user_id
  belongs_to :post

  after_save :update_comments_counter

  private

  def update_comments_counter
    comments_number = Comment.where(post: post).count('id')
    post.update(comments_counter: comments_number)
  end
end
