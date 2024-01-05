class PostsLikeSerializer
  include JSONAPI::Serializer
  attributes :created_at, :updated_at
  belongs_to :post
  belongs_to :user
end
