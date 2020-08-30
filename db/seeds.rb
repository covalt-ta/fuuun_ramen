# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# 10.times do
#   Product.create!(
#     name: Faker::Book.title,
#     text: Faker::Lorem.paragraph,
#     price: Faker::Number.within(range: 500..10000),
#     category_id: %w(2 3 4 5 6 7).sample,
#     admin_id: 1
#   )
# end

Admin.create!(
  name: "kota",
  email: "kota@gmail.com",
  password: "taku1234"
)
