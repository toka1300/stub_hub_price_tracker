require "database_cleaner"

DatabaseCleaner.clean_with(:truncation)

# db/seeds.rb

# Create a main sample user.
User.create!(name:                  "Casey Tokarchuk",
             email:                 "caseytokarchuk@gmail.com",
             password:              "123456",
             password_confirmation: "123456",
             admin:                  true,
             activated:              true,
             activated_at:           Time.zone.now)

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

# -------- Events ----------

events = [
  {
    name: "Concert of the Century",
    date: "2024-12-15",
    venue: "Madison Square Garden",
    live_price_cad: 150,
    live_price_usd: 110,
    url: "https://www.stubhub.com/concert-of-the-century",
    event_type: "sports",
    stubhub_id: "event001",
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
    stubhub_id: "event002",
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
    stubhub_id: "event003",
    image_url: "https://images.pexels.com/photos/26840203/pexels-photo-26840203/free-photo-of-ice-hockey-game.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
  }
]

50.times do
  rand_number = rand(0..2)
  Event.create!(events[rand_number])
end

# Price Alerts
60.times do
  User.first.price_alerts.create!(
  event_id: rand(1..3),
  alert_price: rand(125..350)
  )
end

20.times do
  User.second.price_alerts.create!(
  event_id: rand(1..3),
  alert_price: rand(125..350)
  )
end
