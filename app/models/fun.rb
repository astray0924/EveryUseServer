class Fun < ActiveRecord::Base
  validates_uniqueness_of :user_id, :scope => :use_case_id
  
  belongs_to :user, :counter_cache => true
  belongs_to :use_case, :counter_cache => true
end
