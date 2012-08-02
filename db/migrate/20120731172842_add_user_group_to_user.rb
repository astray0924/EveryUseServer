class AddUserGroupToUser < ActiveRecord::Migration
  def change
   change_table :users do |t|
      t.string :user_group, :default => ""
    end
  end
end
