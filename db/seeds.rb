# This file should contain all the record creation needed to seed the database
# with its default values.
# The data can then be loaded with the rake db:seed (or created alongside
# the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(last_name: 'Arroway', first_name: 'Ellie',
  email: 'ellie_arroway@railstutorial.org', password: '3.1415926',
  password_confirmation: '3.1415926', confirmed_at: Time.now)

49.times do |n|
  name_l = Faker::Name.last_name
  name_f = Faker::Name.first_name
  email_address = "example-#{n + 1}@railstutorial.org"

  User.create!(last_name: name_l, first_name: name_f, email: email_address,
    password: 'password1', password_confirmation: 'password1',
    confirmed_at: Time.now)
end

50.times do
  name_l = Faker::Name.last_name
  name_f = Faker::Name.first_name
  email_address = Faker::Internet.email(name_f)

  User.create!(last_name: name_l, first_name: name_f, email: email_address,
    password: 'password1', password_confirmation: 'password1',
    confirmed_at: Time.now)
end

Admin.create!(last_name: 'Tarter', first_name: 'Jill',
  email: 'jill_tarter@railstutorial.org', password: 'SETI Institute',
  password_confirmation: 'SETI Institute', confirmed_at: Time.now)

49.times do |n|
  name_l = Faker::Name.last_name
  name_f = Faker::Name.first_name
  email_address = "admin-#{n + 1}@railstutorial.org"

  Admin.create!(last_name: name_l, first_name: name_f, email: email_address,
    password: 'password1', password_confirmation: 'password1',
    confirmed_at: Time.now)
end

50.times do
  name_l = Faker::Name.last_name
  name_f = Faker::Name.first_name
  email_address = Faker::Internet.email(name_f)

  Admin.create!(last_name: name_l, first_name: name_f, email: email_address,
    password: 'password1', password_confirmation: 'password1',
    confirmed_at: Time.now)
end
