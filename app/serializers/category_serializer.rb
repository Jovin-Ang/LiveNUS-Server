class CategorySerializer
  include JSONAPI::Serializer
  attributes :name, :description
  has_many :posts, meta: Proc.new { |category, params|
    { count: category.posts.length }
  } do |category|
    category.posts.order(created_at: :desc)
  end
end
