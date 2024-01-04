class PostSerializer
  include JSONAPI::Serializer

  attributes :title, :body
  meta do |post|
    {
      likes: post.posts_likes.length,
      upvotes: post.posts_votes.select{|post_vote| post_vote.vote == 1}.length,
      downvotes: post.posts_votes.select{|post_vote| post_vote.vote == 2}.length,
    }
  end
  belongs_to :user
  belongs_to :category
  belongs_to :status
  has_many :comments, if: Proc.new { |post, params|
    # Comments will be serialized only if the :fetch_comments key of params is true
    params && params[:fetch_comments] == true
  } do |post|
    post.comments.order(created_at: :desc)
  end
  has_many :posts_likes, lazy_load_data: true
  has_many :posts_votes, lazy_load_data: true
end
