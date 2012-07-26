class RenameFunToWow < ActiveRecord::Migration
  def change
    rename_table :funs, :wows
  end
end
