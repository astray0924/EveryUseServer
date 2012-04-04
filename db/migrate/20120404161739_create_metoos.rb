class CreateMetoos < ActiveRecord::Migration
  def change
    create_table :metoos do |t|
      t.references :user
      t.references :use_case
      
      t.timestamps
    end
  end
end
