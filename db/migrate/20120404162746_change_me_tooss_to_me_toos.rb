class ChangeMeToossToMeToos < ActiveRecord::Migration
  def change
    rename_column(:use_cases, :metooss_count, :metoos_count)
    rename_column(:users, :metooss_count, :metoos_count)
  end
end
