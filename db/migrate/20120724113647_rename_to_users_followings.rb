class RenameToUsersFollowings < ActiveRecord::Migration
  def up
     rename_table :user_relations, :users_followings 
     rename_column :users_followings, :followee_id, :following_id
     rename_column :users_followings, :follower_id, :user_id
  end

  def down
    rename_table :users_followings, :user_relations
    rename_column :user_relations, :following_id, :followee_id
     rename_column :user_relations, :user_id, :follower_id
  end
end
