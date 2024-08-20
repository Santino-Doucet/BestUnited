# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts "Destroying all user"
User.destroy_all
puts "Destroyin all items"
Item.destroy_all
puts "Destroying all Compgny"
Company.destroy_all


puts "Create commercant"
commercant = User.create!(
  email: 'commercant@test.fr',
  password: 'password',
  age: 20,
  gender: 'Homme',
  address: '22 rue des capucins Lyon',
  phone_number: '0601020304',
  first_name: 'Santino',
  last_name: 'Doucet'
);

puts "Create test user"
user = User.create!(
  email: 'user@test.fr',
  password: 'password',
  age: 31,
  gender: 'Femme',
  address: '2 rue des capucins Lyon',
  phone_number: '0601020305',
  first_name: 'Amandine',
  last_name: 'Porte'
)


puts "Create company"
company = Company.create!(
  siren: '09909009990090090',
  name: 'Best United Store',
  address: '4 rue des capucins Lyon',
  user: commercant
)

puts "Create stock"
25.times do
  Item.create!(
    reference: Faker::Alphanumeric.alpha(number: 10), #To add real reference with API
    brand: "Nike",
    model: "Air Force",
    color: "Red",
    price: Faker::Number.between(from: 47.0, to: 600.0),
    company: company,
    size: Faker::Number.between(from: 32, to: 46)
  )
end

puts "================================="
puts "Commercant =>"
puts "id: #{commercant.id}"
puts "email: #{commercant.email}"
puts "password: password"
puts "================================="
puts "Company =>"
puts "id: #{company.id}"
puts "name: #{company.name}"
puts "================================="
puts "User lambda =>"
puts "id: #{user.id}"
puts "email: #{user.email}"
puts "password: password"
