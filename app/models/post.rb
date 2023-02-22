class Post < ApplicationRecord
  has many :comments
  has many :likes
  belongs_to :author, class_name: 'User'
end