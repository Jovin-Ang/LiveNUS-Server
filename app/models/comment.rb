class Comment < ApplicationRecord
  validates :post_id, :user_id, presence: true, strict: true
  validates :body, length: { maximum: 400 }, presence: true, strict: true
  belongs_to :post
  belongs_to :user
  has_many :comments_likes
  has_many :comments_votes
end
