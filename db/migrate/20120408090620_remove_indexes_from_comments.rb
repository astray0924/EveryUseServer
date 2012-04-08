class RemoveIndexesFromComments < ActiveRecord::Migration
  def change
    remove_index :favorites, :column => [:user_id, :use_case_id]
    remove_index :funs, :column => [:user_id, :use_case_id]
    remove_index :metoos, :column => [:user_id, :use_case_id]
  end
end
