# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


## Create 10 users:
10.times do |time| 
  User.create(
    email: "#{time}@example.com",
    password: "#{time.to_s*7}"
  )
end

## Create 10 doctors:
10.times do |time| 
  Doctor.create(
    email: "#{time.to_s*2}@example.com",
    password: "#{time.to_s*7}"
  )
end