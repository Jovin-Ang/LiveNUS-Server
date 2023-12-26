class CreatePostsLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :posts_likes, primary_key: [:post_id, :user_id] do |t|
      t.references :post, null: false, foreign_key: { on_delete: :cascade }
      t.references :user, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
