class CommentSerializer
  include JSONAPI::Serializer
  attributes :body
  belongs_to :post
  belongs_to :user
  has_many :comments_likes, lazy_load_data: true, meta: Proc.new { |comment, params|
    { count: comment.comments_likes.length }
  }
  has_many :comments_votes, lazy_load_data: true, meta: Proc.new { |comment, params|
    {
      count: comment.comments_votes.length,
      upvotes: comment.comments_votes.select{|comment_vote| comment_vote.vote == 1}.length,
      downvotes: comment.comments_votes.select{|comment_vote| comment_vote.vote == 2}.length
    }
  }
end
