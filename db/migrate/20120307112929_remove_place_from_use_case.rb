class RemovePlaceFromUseCase < ActiveRecord::Migration
  def up
  	remove_column :use_cases, :place
  end

  def down
  	change_table :use_cases do |t|
  		t.string :place
  	end
  end
end
