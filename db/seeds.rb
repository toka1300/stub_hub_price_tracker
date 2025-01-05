# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

# db/seeds.rb

# Create a main sample user.
User.create!(name:  "Casey Tokarchuk",
             email: "caseytokarchuk@gmail.com",
             password:              "123456",
             password_confirmation: "123456",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

# Generate a bunch of additional users.
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

Event.create([
  {
    name: "Concert of the Century",
    date: "2024-12-15",
    venue: "Madison Square Garden",
    live_price_cad: 150,
    live_price_usd: 110,
    url: "https://www.stubhub.com/concert-of-the-century",
    event_type: "sports",
    event_id: "event001",
    image_url: "https://images.pexels.com/photos/1105666/pexels-photo-1105666.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
  },
  {
    name: "Broadway Musical Night",
    date: "2024-12-20",
    venue: "Broadway Theater",
    live_price_cad: 200,
    live_price_usd: 150,
    url: "https://www.stubhub.com/broadway-musical-night",
    event_type: "sports",
    event_id: "event002",
    image_url: "https://images.pexels.com/photos/11534855/pexels-photo-11534855.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
  },
  {
    name: "Sports Finals",
    date: "2024-12-25",
    venue: "Wembley Stadium",
    live_price_cad: 300,
    live_price_usd: 220,
    url: "https://www.stubhub.com/sports-finals",
    event_type: "sports",
    event_id: "event003",
    image_url: "https://images.pexels.com/photos/26840203/pexels-photo-26840203/free-photo-of-ice-hockey-game.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
  }
])
