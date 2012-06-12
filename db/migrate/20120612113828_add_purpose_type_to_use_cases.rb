class AddPurposeTypeToUseCases < ActiveRecord::Migration
  def change
    change_table :use_cases do |t|
      t.string :purpose_type, :default => ""
    end
  end
end
