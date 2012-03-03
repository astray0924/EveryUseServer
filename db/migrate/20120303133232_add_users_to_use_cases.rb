class AddUsersToUseCases < ActiveRecord::Migration
  def change
    change_table :use_cases do |t|
      t.references :user
    end
  end
end
