class RemoveFollowingsTable < ActiveRecord::Migration
  def up
    drop_table :users_followings
  end

  def down
  end
end
