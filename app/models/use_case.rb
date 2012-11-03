class UseCase < ActiveRecord::Base
  require 'date'
  
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
    super(:methods => [:writer_id, :writer_name, :user_group, :converted_file_name])
  end
  
  def writer_id
	if not user_id.blank? 
		return user_id
	end
  end
  
  def writer_name
    if user_id.blank?
      @username = nil
    else
      @username = User.find(user_id).username
    end
  end

  def converted_file_name
    @file_name = self.photo.url(:thumb).split('/').last.split('?').first
  end
  
  def get_date_string
    posted_date = self.created_at
    
    if Time.now - posted_date == 1.days.ago
      date_string = 'Yesterday'
    elsif Time.now - posted_date == 0.days.ago
      date_string = 'Today'
    else
      date_string = posted_date.strftime('%Y-%d-%m')
    end
  end
  
  def to_s
    "#{self.item} #{self.purpose_type} #{self.purpose}"
  end
end
