class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_save :update_like_counter_in_post

  def update_like_counter_in_post
    author.increment!(:likes_counter)
  end
end
