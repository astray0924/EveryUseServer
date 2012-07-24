class RenameFollowerToFollowed < ActiveRecord::Migration
  def up
     rename_column :users_followings, :following_id, :followed_id
  end

  def down
    rename_column :users_followings, :followed_id, :following_id
  end
end
