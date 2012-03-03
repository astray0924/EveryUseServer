class AddAttachmentPhotoToUseCase < ActiveRecord::Migration
  def self.up
    add_column :use_cases, :photo_file_name, :string
    add_column :use_cases, :photo_content_type, :string
    add_column :use_cases, :photo_file_size, :integer
    add_column :use_cases, :photo_updated_at, :datetime
  end

  def self.down
    remove_column :use_cases, :photo_file_name
    remove_column :use_cases, :photo_content_type
    remove_column :use_cases, :photo_file_size
    remove_column :use_cases, :photo_updated_at
  end
end
