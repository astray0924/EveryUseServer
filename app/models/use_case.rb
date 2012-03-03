class UseCase < ActiveRecord::Base
  belongs_to :user

  has_attached_file :photo, :styles => {:thumb => "100x100#", :large => "400x400>"},
                    :url => "/:attachment/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/:attachment/:id/:style/:basename.:extension"
end
