class AddIndexToComment < ActiveRecord::Migration
  def change
  end
  
  add_index :comments, [:user_id, :use_case_id], :unique => true
end
