class AddUserGroupColumnToUseCases < ActiveRecord::Migration
  def change
    change_table :use_cases do |t|
      t.string :user_group, :default => ""
    end
  end
end
