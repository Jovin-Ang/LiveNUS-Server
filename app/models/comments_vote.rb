class CommentsVote < ApplicationRecord
  self.primary_key = [:comment_id, :user_id]
  validates :comment_id, :user_id, :vote, presence: true
  belongs_to :comment
  belongs_to :user
end
