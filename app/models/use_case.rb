class UseCase < ActiveRecord::Base
  # xlsx로 표현하기 위해 플러그인 추가
  acts_as_xlsx :columns => [:id, :writer_name, :user_group, :item, :purpose, :created_at]
  
  belongs_to :user, :counter_cache => true
  has_many :favorite, :dependent => :destroy
  has_many :wow, :dependent => :destroy
  has_many :metoo, :dependent => :destroy
  
  # default order
  default_scope :order => 'created_at DESC'

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
  
  def UseCase.filter_by_user_group(user_group)
	return UseCase.includes(:user).all.select{ |use_case| use_case.user.user_group.eql?(user_group) }
  end
  
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
  
  def user_group
	if not self.user.blank?
		@user_group = self.user.user_group
	end
  end

  def converted_file_name
    @file_name = self.photo.url(:thumb).split('/').last.split('?').first
  end
end
