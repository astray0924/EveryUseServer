class UseCase < ActiveRecord::Base
  belongs_to :user
  
  has_attached_file :photo, :styles => {:thumb => "100x100#",   :small => "150x150>",   :large => "400x400>" }
end
