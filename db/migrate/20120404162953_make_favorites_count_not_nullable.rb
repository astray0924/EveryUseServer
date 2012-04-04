class MakeFavoritesCountNotNullable < ActiveRecord::Migration
  def change
    change_column(:users, :favorites_count, :integer, {:null => false, :default => 0})
    change_column(:use_cases, :favorites_count, :integer, {:null => false, :default => 0})
  end
end
