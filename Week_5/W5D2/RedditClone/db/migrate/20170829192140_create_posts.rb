class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.text :title, null:false
      t.text :url
      t.text :content
      t.integer :user_id, null:false

      t.timestamps
    end
    add_index :posts, :user_id
  end
end
