class AddPlaceToUseCase < ActiveRecord::Migration
  def change
    change_table :use_cases do |t|
      t.string :place, :default => ""
    end
  end
end
