class Metoo < ActiveRecord::Base
  belongs_to :user, :counter_cache => true
  belongs_to :use_case, :counter_cache => true
end