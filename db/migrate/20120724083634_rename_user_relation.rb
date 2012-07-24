class RenameUserRelation < ActiveRecord::Migration
  def change
    rename_table :user_relation, :user_relations
  end
end
