class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :comments, dependent: :delete_all, foreign_key: 'author_id'
  has_many :posts, dependent: :delete_all, foreign_key: 'author_id'
  has_many :likes, dependent: :delete_all, foreign_key: 'author_id'

  ROLES = %i[admin default].freeze

  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def most_recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
