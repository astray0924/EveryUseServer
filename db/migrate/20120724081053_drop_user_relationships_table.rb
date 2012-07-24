class DropUserRelationshipsTable < ActiveRecord::Migration
  def up
    drop_table :user_relationships
  end

  def down
  end
end
