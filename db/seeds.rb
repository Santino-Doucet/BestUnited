require 'uri'
require 'net/http'
require 'json'
require 'date'

##########################################################

puts "Destroying all user"
User.destroy_all
puts "Destroying all items"
Item.destroy_all
puts "Destroying all companies"
Company.destroy_all

##########################################################

url = URI("https://v1-sneakers.p.rapidapi.com/v1/sneakers?limit=60")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true

request = Net::HTTP::Get.new(url)
request["x-rapidapi-key"] = ENV['X_RAPIDAPI_KEY']
request["x-rapidapi-host"] = ENV['X_RAPIDAPI_HOST']

response = http.request(request)
shoes = JSON.parse(response.read_body)["results"]

##########################################################

puts "Create merchant Santino"
commercant = User.create!(
  email: 'commercant1@test.fr',
  password: 'password',
  age: 20,
  gender: 'Homme',
  address: '22 rue des capucins Lyon',
  phone_number: '0601020304',
  first_name: 'Santino',
  last_name: 'Doucet'
);

puts "Create merchant Ji-Fang"
commercant2 = User.create!(
  email: 'commercant2@test.fr',
  password: 'password',
  age: 27,
  gender: 'Femme',
  address: '2 Place Lucien Artaud, Bandol',
  phone_number: '0601020310',
  first_name: 'Ji-Fang',
  last_name: 'Lo'
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


puts "Create company 1"
company = Company.create!(
  siren: '987654321',
  name: 'Best United Store',
  address: '4 rue des capucins Lyon',
  user: commercant
)

puts "Create company 2"
company2 = Company.create!(
  siren: '123456789',
  name: 'JLO Shop',
  address: '2 Place Lucien Artaud, Bandol',
  user: commercant2
)

companies = [company, company2]

puts 'Create stock'
shoes.each do |shoe|
  next if shoe['media']['imageUrl'].nil?
  rand(1..5).times do
    url = shoe['media']['imageUrl'].gsub(' ', '')
    begin
      company = companies.sample
      size = Faker::Number.between(from: 38, to: 45)
      rand(1..3).times do
        item = Item.create!(
          reference: shoe['styleId'],
          brand: shoe['brand'],
          model: shoe['name'],
          color: shoe['colorway'],
          price: shoe['retailPrice'],
          company: company,
          size: size,
          released_on: Date.new(shoe['year'].to_i)
        )
        file = URI.open(url)
        item.photo.attach(io: file, filename: 'shoe.png', content_type: 'image/png')
      end
    rescue OpenURI::HTTPError => e
      puts "Could not fetch image from URL: #{url}. Error: #{e.message}"
      next
    end
  end
end

puts "================================="
puts "Commercant 1 =>"
puts "id: #{commercant.id}"
puts "email: #{commercant.email}"
puts "password: password"
puts "================================="
puts "Commercant 2 =>"
puts "id: #{commercant2.id}"
puts "email: #{commercant2.email}"
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
