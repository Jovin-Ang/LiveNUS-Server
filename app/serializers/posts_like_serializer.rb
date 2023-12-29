class PostsLikeSerializer
  include JSONAPI::Serializer
  attributes
  belongs_to :post
  belongs_to :user
end
