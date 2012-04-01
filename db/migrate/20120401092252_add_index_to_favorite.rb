class AddIndexToFavorite < ActiveRecord::Migration
  def change
    add_index :favorites, [:user_id, :use_case_id], :unique => true
  end
end
