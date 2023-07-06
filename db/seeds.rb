# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Category.create([{ name: 'Work' }, { name: 'Hobby' }, { name: 'Games' }])

5.times do
  User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email
  )
end

users = User.all
categories = Category.all
states = Bulletin.aasm.states.map(&:name)

150.times do
  bulletin = Bulletin.new(
    title: Faker::Beer.name,
    description: Faker::Lorem.paragraph_by_chars,
    user: users.sample,
    category: categories.sample,
    state: states.sample
  )

  bulletin.image.attach(io: File.open('test/fixtures/files/deathly_hallows.png'), filename: 'deathly_hallows.png')

  bulletin.save!
end
