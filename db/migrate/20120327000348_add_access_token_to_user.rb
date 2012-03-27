class AddAccessTokenToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :single_access_token, :null => false, :default => ""
    end
  end
end
