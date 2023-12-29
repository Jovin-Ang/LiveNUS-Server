class CommentsLikeSerializer
  include JSONAPI::Serializer
  attributes
  belongs_to :comment
  belongs_to :user
end
