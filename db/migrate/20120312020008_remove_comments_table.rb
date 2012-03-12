class RemoveCommentsTable < ActiveRecord::Migration
  def up
    drop_table :comments
    remove_column :use_cases, :comments_count
    remove_column :users, :comments_count
  end
  
  def down
    
  end
end
