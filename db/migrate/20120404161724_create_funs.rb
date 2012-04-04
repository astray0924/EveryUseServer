class CreateFuns < ActiveRecord::Migration
  def change
    create_table :funs do |t|
      t.references :user
      t.references :use_case
      
      t.timestamps
    end
  end
end
