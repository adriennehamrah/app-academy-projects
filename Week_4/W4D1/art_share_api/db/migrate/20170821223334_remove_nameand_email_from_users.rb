class RemoveNameandEmailFromUsers < ActiveRecord::Migration[5.1]

  def up
    remove_column :users, :name
    remove_column :users, :email
  end

  def down
    add_column :users, :name, :string, null: false
    add_column :users, :email, :string, null: false
  end
end
