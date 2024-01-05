class CommentsLikeSerializer
  include JSONAPI::Serializer
  attributes :created_at, :updated_at
  belongs_to :comment
  belongs_to :user
end
