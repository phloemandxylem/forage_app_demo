# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'random_data'
50.times do
# #1
  Wiki.create!(
# #2
    title:  RandomData.random_sentence,
    body:   RandomData.random_paragraph
  )
end
wiki = Wiki.all

admin = User.create!(
   name:     'Admin User',
   email:      'admin@example.com',
   password: 'helloworld',
   role:          'admin'
 )

 member = User.create!(
   name:     'Member User',
   email:    'member@example.com',
   password: 'helloworld'
 )


puts "Seed finished"
puts "#{Wiki.count} wikis created"
