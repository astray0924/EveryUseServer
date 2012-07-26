class REmoveUserGroupFromUseCases < ActiveRecord::Migration
  def change
    remove_column :use_cases, :user_group
  end
end
