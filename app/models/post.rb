class Post < ApplicationRecord
  validates :title, length: { maximum: 100 }, presence: true
  validates :body, length: { maximum: 400 }, presence: true
  validates :user_id, :category_id, :status_id, presence: true
  belongs_to :user
  belongs_to :category
  belongs_to :status
  has_many :comments
  has_many :posts_likes
  has_many :posts_votes
end
