# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
host = User.new(:name=>"host")
host.save

guest = User.new(:name=>"guest")
guest.save

room1 = Room.new(:user_id=>host.id,:name=>"Room1")
room1.save

messageHost = Message.new(:content=>"hello world from host", :user_id=>host.id, :room_id=>room1.id) 
messageHost.save

messageGuest = Message.new(:content=>"hello world from guest", :user_id=>host.id,:room_id=>room1.id) 
messageGuest.save