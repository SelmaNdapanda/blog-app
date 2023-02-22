class Post < ApplicationRecord
  has_many :comments
  has_many :likes
  belongs_to :author, class_name: 'User'

  def update_post_counter_in_user
    users.post_counter.update
  end

  def most_recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end