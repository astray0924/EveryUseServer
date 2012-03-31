class RenameUsecaseColumn < ActiveRecord::Migration
  def change
    rename_column(:use_cases, :product, :item)
    rename_column(:use_cases, :function, :purpose)
  end
end
