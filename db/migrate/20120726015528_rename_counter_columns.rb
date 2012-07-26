class RenameCounterColumns < ActiveRecord::Migration
  def change
    rename_column :users, :funs_count, :wows_count
    rename_column :use_cases, :funs_count, :wows_count
  end
end
