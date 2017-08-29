class CreateUsercomments < ActiveRecord::Migration[5.1]
  def change
    create_table :usercomments do |t|
      t.text :body, null: false
      t.integer :user_id, null:false

      t.timestamps
    end
    add_index :usercomments, :user_id
  end
end
