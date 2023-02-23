class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  def update_comment_counter_in_post
    posts.increment!(:comments_counter)
  end
end
