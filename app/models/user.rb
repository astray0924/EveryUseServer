class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :use_cases, :dependent => :destroy, :order => 'updated_at DESC'
  has_many :favorite, :dependent => :destroy
  has_many :fun, :dependent => :destroy
  has_many :metoo, :dependent => :destroy
  has_many :followers, :class_name => 'Followings', :foreign_key => 'followee_id'
  has_many :followees, :class_name => 'Followings', :foreign_key => 'follower_id'
  
  validates :username, :uniqueness => true, :presence => true
  validates :email, :uniqueness => true, :presence => true
  validates :password, :presence => true
end
