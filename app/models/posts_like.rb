class PostsLike < ApplicationRecord
  self.primary_key = [:post_id, :user_id]
  validates :post_id, :user_id, presence: true
  belongs_to :post
  belongs_to :user
end
