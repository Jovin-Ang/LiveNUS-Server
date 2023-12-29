class CommentsVoteSerializer
  include JSONAPI::Serializer
  attributes :vote
  belongs_to :comment
  belongs_to :user
end
