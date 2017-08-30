class CreateSubs < ActiveRecord::Migration[5.1]
  def change
    create_table :subs do |t|
      t.text :title, null:false
      t.text :description, null:false
      t.text :user_id, null:false

      t.timestamps
    end
    add_index :subs, :user_id
  end
end
