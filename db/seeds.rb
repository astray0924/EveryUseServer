# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'json'

# create new user 'olduser'
old_user = User.new(username: 'olduser', email: 'old@old.com', password: 'olduser', password_confirmation: 'olduser')
if old_user.valid?
	old_user.save()
else
	puts old_user.errors.full_messages
end

# create test user
test_user = User.new(username: 'test', email: 'test@test.com', password: 'test', password_confirmation: 'test')
if test_user.valid?
  test_user.save()
else
  puts test_user.errors.full_messages
end

# parse seed JSON
# seed_file = File.open('db/seed/seed.json', 'r')
# 
# seed_file.each do |l|
	# json = JSON.parse(l)
# 	
	# id = json['id']	# 이건 case의 고유 아이디. 일단 받아옴
	# dummy = File.open("db/seed/photo/dummy.png", 'rb')
# 	
	# begin
		# photo = File.open("db/seed/photo/#{id}.png", 'rb')
	# rescue
		# photo = dummy
	# end
# 	
	# user_id = User.where('username = ?', 'olduser')
	# item = json['item']
	# purpose = json['purpose']
	# uploadDateTime = json['uploadDateTime']
# 	
	# use_case = UseCase.new(:user_id => user_id, :item => item, :purpose => purpose, :photo => photo, :purpose_type => "as", :created_at => uploadDateTime)
# 	
	# if !UseCase.where("item = ? AND purpose = ?", item, purpose).exists?
	  # if use_case.valid?
  		# use_case.save()
    # else
      # print use_case.errors.full_messages
	  # end
	# end
# 	
	# # close the photo file
	# if !photo.nil?
		# photo.close
	# end
# end
