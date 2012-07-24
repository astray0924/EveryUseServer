class AddIndexToFollowings < ActiveRecord::Migration
  def change
    add_index "followings", ["follower_id", "followee_id"], :name => "index_followings", :unique => true
  end
end
