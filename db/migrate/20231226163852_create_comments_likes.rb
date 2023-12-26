class CreateCommentsLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :comments_likes, primary_key: [:comment_id, :user_id] do |t|
      t.references :comment, null: false, foreign_key: { on_delete: :cascade }
      t.references :user, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
