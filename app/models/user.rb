class User < ActiveRecord::Base
  acts_as_authentic

  has_many :use_cases, :dependent => :destroy, :order => 'updated_at DESC'
  has_many :favorite, :dependent => :destroy
  has_many :fun, :dependent => :destroy
  has_many :metoo, :dependent => :destroy
  # has_many :followers, :class_name => 'UserRelation', :foreign_key => 'followee_id'
  # has_many :followees, :class_name => 'UserRelation', :foreign_key => 'follower_id'
  
  # Create the following relationship
  has_and_belongs_to_many :followings,
        :association_foreign_key => 'following_id',
        :class_name => 'User',
        :join_table => 'users_followings'

  # Create the follower relationship
  has_and_belongs_to_many :followers,
        :foreign_key => 'following_id',
        :association_foreign_key => 'user_id',
        :class_name => 'User',
        :join_table => 'users_followings'

  validates :username, :uniqueness => true, :presence => true
  validates :email, :uniqueness => true, :presence => true
  validates :password, :presence => true
end
