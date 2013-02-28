class UseCase < ActiveRecord::Base
  require 'date'
  require 'FileUtils'

  attr_accessor :current_user_favorite, :current_user_wow, :current_user_metoo

  belongs_to :user, :counter_cache => true
  has_many :favorite, :dependent => :destroy
  has_many :wow, :dependent => :destroy
  has_many :metoo, :dependent => :destroy

  has_attached_file :photo, :styles => {:thumb => ["100x100#", :jpg], :large => ["400x400>", :jpg]},
  :default_style => :thumb,
  :url => "/:attachment/:id/:basename_:style.:extension",
  :path => ":rails_root/public/:attachment/:id/:basename_:style.:extension"

  # belongs_to
  belongs_to :ref_all, :class_name => "UseCase", :foreign_key => "ref_all_id"
  belongs_to :ref_item, :class_name => "UseCase", :foreign_key => "ref_item_id"
  belongs_to :ref_purpose, :class_name => "UseCase", :foreign_key => "ref_purpose_id"

  # validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_presence :photo
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/bmp']
  validates :user_id, :presence => true
  validates :item, :presence => true, :length => { :maximum => 35 }
  validates :purpose, :presence => true, :length => { :maximum => 40 }

  after_save :generate_image_using_id

  def generate_image_using_id
    path = self.photo.path(:original)
    FileUtils.cp(path, File.join(File.dirname(path), self.id.to_s + File.extname(path)))
  end

  def as_json(options)
    super(:methods => [:writer_id, :writer_name, :user_group, :photo_file_name_large, :photo_file_name_thumb])
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
  
  def photo_file_name_large
    self.photo.url(:large).split('/').last.split('?').first
  end
  
  def photo_file_name_thumb
    self.photo.url(:thumb).split('/').last.split('?').first
  end

  def get_date_string
    posted_date = self.created_at

    if posted_date.today?
      date_string = 'Today'
    else
      date_string = posted_date.strftime('%Y-%m-%d')
    end

    return date_string
  end

  def to_s
    "#{self.item} #{self.purpose} #{self.purpose_type}"
  end
end
