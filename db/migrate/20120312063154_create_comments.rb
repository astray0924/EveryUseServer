class CreateComments < ActiveRecord::Migration
	def change
		create_table :comments do |t|
			t.integer :user_id
			t.integer :use_case_id
			t.boolean :like

			t.timestamps
		end
	end
end
