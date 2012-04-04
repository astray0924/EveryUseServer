class CreateMetoos < ActiveRecord::Migration
  def change
    create_table :metoos do |t|

      t.timestamps
    end
  end
end
