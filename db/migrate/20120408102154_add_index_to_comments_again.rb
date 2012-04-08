class AddIndexToCommentsAgain < ActiveRecord::Migration
  def change
    add_index :favorites, [:user_id, :use_case_id], :unique => true
    add_index :funs, [:user_id, :use_case_id], :unique => true
    add_index :metoos, [:user_id, :use_case_id], :unique => true
  end
end
