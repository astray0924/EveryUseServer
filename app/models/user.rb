class User < ActiveRecord::Base
  acts_as_authentic

  has_many :use_cases, :dependent => :destroy, :order => 'updated_at DESC'
  has_many :favorite, :dependent => :destroy
  has_many :wow, :dependent => :destroy
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
  def feeds(page, limit)
    @feeds = Array.new

    followed_users.each do |user|
      @feeds |= user.use_cases
    end

    return @feeds.sort! {|x, y| y.created_at <=> x.created_at}.paginate(:page => @page, :per_page => @limit)
  end

  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(:followed_id => other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end
end
