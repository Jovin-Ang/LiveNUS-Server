class PostsVoteSerializer
  include JSONAPI::Serializer
  attributes :vote
  belongs_to :post
  belongs_to :user
end
