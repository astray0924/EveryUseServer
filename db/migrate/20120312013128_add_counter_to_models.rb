class AddCounterToModels < ActiveRecord::Migration
  def change
    change_table :use_cases do |t|
      t.integer :comments_count, :default => 0
    end
    
    change_table :users do |t|
      t.integer :comments_count, :default => 0
      t.integer :use_cases_count, :default => 0
    end
  end
end
