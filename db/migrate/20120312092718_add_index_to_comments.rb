class AddIndexToComments < ActiveRecord::Migration
  def change
    add_index :comments, [:user_id, :use_case_id], :unique => true
  end
end
