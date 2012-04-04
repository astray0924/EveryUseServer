class AddCommentsCounterToUserAndUseCase < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.integer :funs_count, :default => 0, :null => false
      t.integer :metooss_count, :default => 0, :null => false
    end

    change_table :use_cases do |t|
      t.integer :funs_count, :default => 0, :null => false
      t.integer :metooss_count, :default => 0, :null => false
    end

    add_index :funs, [:user_id, :use_case_id], :unique => true
    add_index :metoos, [:user_id, :use_case_id], :unique => true
  end
end
