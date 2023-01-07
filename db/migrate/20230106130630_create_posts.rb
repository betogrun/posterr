class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :content
      t.references :original_post, null: true, foreign_key: { to_table: :posts }
      t.string :quote
      t.string :kind

      t.timestamps
    end
  end
end
