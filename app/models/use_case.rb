class UseCase < ActiveRecord::Base
  belongs_to :user, :counter_cache => true
  has_many :favorite, :dependent => :destroy
  has_many :fun, :dependent => :destroy
  has_many :metoo, :dependent => :destroy

  has_attached_file :photo, :styles => {:thumb => ["100x100#", :jpg], :large => ["400x400>", :jpg]},
                    :url => "/:attachment/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/:attachment/:id/:style/:basename.:extension"

  # validates_attachment_presence :photo
  # validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/bmp']
  validates :user_id, :presence => true
  def as_json(options)
    super(:methods => [:username])
  end

  def username
    if user_id.blank?
      @username = nil
    else
      @username = User.find(user_id).username
    end

  end
end
