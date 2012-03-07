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

# parse seed JSON
seed_file = File.open('db/seed/seed.json', 'r')

seed_file.each do |l|
	json = JSON.parse(l)
	
	id = json['id']	# 이건 case의 고유 아이디. 일단 받아옴
	dummy = File.open("db/seed/photo/dummy.png", 'rb')
	
	begin
		photo = File.open("db/seed/photo/#{id}.png", 'rb')
	rescue
		photo = dummy
	end
	
	user_id = User.where('username = ?', 'olduser')
	product = json['product']
	function = json['function']
	uploadDateTime = json['uploadDateTime']
	
	use_case = UseCase.new(:user_id => user_id, :product => product, :function => function, :photo => photo, :created_at => uploadDateTime)
	
	if !UseCase.where("product = ? AND function = ?", product, function).exists?
		use_case.save()
	end
	
	# close the photo file
	if !photo.nil?
		photo.close
	end
end
