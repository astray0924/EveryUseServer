class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.boolean :fun, :null => false, :default => false
      t.boolean :try, :null => false, :default => false
      t.boolean :metoo, :null => false, :default => false

      t.timestamps
    end
  end
end
