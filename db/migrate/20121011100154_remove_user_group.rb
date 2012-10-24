class RemoveUserGroup < ActiveRecord::Migration
  def change
    drop_table :user_groups if ActiveRecord::Base.connection.tables.include?("user_groups")
    remove_column :users, :user_group
  end
end
