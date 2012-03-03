class CreateUseCases < ActiveRecord::Migration
  def change
    create_table :use_cases do |t|
      t.string :product
      t.string :function
      t.string :place

      t.timestamps
    end
  end
end
