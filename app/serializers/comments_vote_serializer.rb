class CommentsVoteSerializer
  include JSONAPI::Serializer
  attributes :vote, :created_at, :updated_at
  belongs_to :comment
  belongs_to :user
end
