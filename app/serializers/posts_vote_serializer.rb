class PostsVoteSerializer
  include JSONAPI::Serializer
  attributes :vote, :created_at, :updated_at
  belongs_to :post
  belongs_to :user
end
