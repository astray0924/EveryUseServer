class AddReferencesToComment < ActiveRecord::Migration
  def change 
    change_table :comments do |t|
      t.references :user
      t.references :use_case
    end 
  end
end
