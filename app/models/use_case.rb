class UseCase < ActiveRecord::Base
  belongs_to :user, :counter_cache => true
  has_many :favorite, :dependent => :destroy
  has_many :wow, :dependent => :destroy
  has_many :metoo, :dependent => :destroy

  has_attached_file :photo, :styles => {:thumb => ["100x100#", :jpg], :large => ["400x400>", :jpg]},
  					:default_style => :thumb,
                    :url => "/:attachment/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/:attachment/:id/:style/:basename.:extension"

  # validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_presence :photo
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/bmp']
  validates :user_id, :presence => true
  validates :item, :presence => true, :length => { :maximum => 35 }
  validates :purpose, :presence => true, :length => { :maximum => 40 }

  attr_accessor :current_user_favorite, :current_user_wow, :current_user_metoo
  
  def as_json(options)
    super(:methods => [:username, :user_group, :converted_file_name])
  end
  
  def username
    if user_id.blank?
      @username = nil
    else
      @username = User.find(user_id).username
    end
  end
  
  def user_group
	if not self.user.blank?
		@user_group = self.user.user_group
	end
  end

  def converted_file_name
    @file_name = self.photo.url(:thumb).split('/').last.split('?').first
  end
end
