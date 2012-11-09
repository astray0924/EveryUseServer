class AddUsersPasswordResetFields < ActiveRecord::Migration
  def up
    add_column :users, :perishable_token, :string, :default => "", :null => false

    add_index :users, :perishable_token
    add_index :users, :email
  end

  def down
    remove_column :users, :perishable_token

    remove_index :users, :perishable_token
    remove_index :users, :email
  end
end
