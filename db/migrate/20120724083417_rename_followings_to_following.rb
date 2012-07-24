class RenameFollowingsToFollowing < ActiveRecord::Migration
  def change
    rename_table :followings, :user_relation
  end
end
