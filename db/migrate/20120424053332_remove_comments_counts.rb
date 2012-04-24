class RemoveCommentsCounts < ActiveRecord::Migration
	def change
		remove_column :use_cases, :comments_count
		remove_column :users, :comments_count
	end
end
