class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.references :user, null: false, foreign_key: { on_delete: :cascade }
      t.references :category, index: true, null: false, foreign_key: { on_delete: :restrict }
      t.references :status, null: false, foreign_key: { on_delete: :restrict }

      t.timestamps
    end
  end
end
