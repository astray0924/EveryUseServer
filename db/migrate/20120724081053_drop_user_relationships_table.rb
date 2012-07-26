class DropUserRelationshipsTable < ActiveRecord::Migration
  def up
    # http://stackoverflow.com/questions/6590107/check-if-a-table-exists-in-rails 참고
    
    # Gives you a listing
    ActiveRecord::Base.connection.tables
    # Checks for existence of kittens table (Kitten model)
    if ActiveRecord::Base.connection.table_exists? 'user_relationships'
      drop_table :user_relationships    
    end
  end

  def down
  end
end
