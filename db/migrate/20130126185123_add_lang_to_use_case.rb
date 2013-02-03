class AddLangToUseCase < ActiveRecord::Migration
  def change
    add_column :use_cases, :lang, :string, :default => ""
  end
end
