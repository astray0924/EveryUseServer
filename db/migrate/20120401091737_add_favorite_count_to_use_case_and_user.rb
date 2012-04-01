class AddFavoriteCountToUseCaseAndUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.integer :favorites_count
    end
    
    change_table :use_cases do |t|
      t.integer :favorites_count
    end
  end
end
