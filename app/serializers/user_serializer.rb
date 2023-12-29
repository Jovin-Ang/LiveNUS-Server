class UserSerializer
  include JSONAPI::Serializer
  attributes :username, :first_name, :last_name
  attribute :email, if: Proc.new { |user, params|
    # The email will be serialized only if the user is the current user
    params&.[](:current_user)&.[](:id) == user.id
  }
  belongs_to :role
  has_many :posts
  has_many :posts_votes
  has_many :posts_likes
  has_many :comments
  has_many :comments_votes
  has_many :comments_likes
end
