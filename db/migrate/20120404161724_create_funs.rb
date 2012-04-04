class CreateFuns < ActiveRecord::Migration
  def change
    create_table :funs do |t|

      t.timestamps
    end
  end
end
