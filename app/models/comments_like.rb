class CommentsLike < ApplicationRecord
  self.primary_key = [:comment_id, :user_id]
  validates :comment_id, :user_id, presence: true, strict: true
  belongs_to :comment
  belongs_to :user
end
