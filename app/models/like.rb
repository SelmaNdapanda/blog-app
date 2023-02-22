class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  def update_like_counter_in_post
    posts.increment!(:likes_counter)
  end
end
