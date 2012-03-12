class AddForeignKeysToComments < ActiveRecord::Migration
  def change
    remove_column :comments, :user_id
    remove_column :comments, :use_case_id
    
    change_table :comments do |t|
      t.references :user
      t.references :use_case
    end
  end
end
