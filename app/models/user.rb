class User < ActiveRecord::Base
  acts_as_authentic

  has_many :use_cases, :dependent => :destroy, :order => 'updated_at DESC'
  has_many :favorite, :dependent => :destroy
  has_many :fun, :dependent => :destroy
  has_many :metoo, :dependent => :destroy

  # 친구 관계
  has_many :relationships, :foreign_key => "follower_id", :dependent => :destroy
  has_many :followed_users, :through => :relationships, :source => :followed

  has_many :reverse_relationships, :foreign_key => "followed_id",
                                   :class_name =>  "Relationship",
                                   :dependent =>   :destroy
  has_many :followers, :through => :reverse_relationships, :source => :follower

  # validation
  validates :username, :uniqueness => true, :presence => true
  validates :email, :uniqueness => true, :presence => true
  validates :password, :presence => true
end
