class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :use_cases, :dependent => :nullify, :order => 'updated_at DESC'
  has_many :comments, :dependent => :nullify
  
  validates :username, :uniqueness => true, :presence => true
  validates :email, :uniqueness => true, :presence => true
end
