class AddRefFieldToUseCases < ActiveRecord::Migration
  def change
    add_column :use_cases, :ref_all_id, :integer
    add_column :use_cases, :ref_item_id, :integer
    add_column :use_cases, :ref_purpose_id, :integer
  end
end
