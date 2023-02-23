class Post < ApplicationRecord
  has_many :comments
  has_many :likes
  belongs_to :author, class_name: 'User'

  after_save :update_post_counter_in_user

  def update_post_counter_in_user
    author.update(posts_counter: author.posts.count)
  end

  def most_recent_comments
    comments.includes(:post).order(created_at: :desc).limit(5)
  end
end
