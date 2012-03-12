class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :use_cases, :dependent => :destroy
  
  validates :username, :uniqueness => true, :presence => true
  validates :email, :uniqueness => true, :presence => true
end
