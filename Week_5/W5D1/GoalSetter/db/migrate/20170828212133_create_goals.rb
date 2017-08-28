class CreateGoals < ActiveRecord::Migration[5.1]
  def change
    create_table :goals do |t|
      t.text :title, null:false
      t.text :details
      t.boolean :private, null:false, default:false
      t.boolean :completed, null:false, default:false
      t.integer :user_id, null:false

      t.timestamps
    end
    add_index :goals, :user_id
  end
end
