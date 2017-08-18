class CreatePolls < ActiveRecord::Migration[5.1]
  def change
    create_table :polls do |t|
      t.integer :user_id
      t.text :title
      t.timestamps
    end
    add_index :polls, :user_id
  end
end
