class CreateGoalcomments < ActiveRecord::Migration[5.1]
  def change
    create_table :goalcomments do |t|
      t.text :body, null: false
      t.integer :goal_id, null: false

      t.timestamps
    end
    add_index :goalcomments, :goal_id
  end
end
