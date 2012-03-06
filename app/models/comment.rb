class Comment < ActiveRecord::Base
  belongs_to :user, :dependent => :destroy
  belongs_to :use_case, :dependent => :destroy
end
