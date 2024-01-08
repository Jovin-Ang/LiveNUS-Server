class CommentSerializer
  include JSONAPI::Serializer
  attributes :body, :created_at, :updated_at
  meta do |comment|
    {
      likes: comment.comments_likes.length,
      upvotes: comment.comments_votes.select{|comment_vote| comment_vote.vote == 1}.length,
      downvotes: comment.comments_votes.select{|comment_vote| comment_vote.vote == 2}.length
    }
  end
  belongs_to :post
  belongs_to :user
  has_many :comments_likes
  has_many :comments_votes
end
