	# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
admin_user = User.create(email: "nguyenngoclan.clc@gmail.com", password: "password")
admin_user.admin = true
admin_user.confirm!

user = User.create(email: "lan.nguyenngoc@2359media.com.vn", password: "password")
user.confirm!

project = Project.create(name: "Ticketee Beta")

State.create(name: "New", background: "#85FF00", color: "white", default: true)
State.create(name: "Open", background: "#00CFFD", color: "white")
State.create(name: "Closed", background: "black", color: "white")

500.times do |i|
  project.tickets.create!(title: "Test", description: "Rails 3 in Action", user: admin_user)
end


