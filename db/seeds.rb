require 'faker'

puts "--- Starting populating database"
suburbs = %w[Brunswick Melbourne South\ Yarra Docklands South\ Melbourne Footscray];
booking_status = %w[confirmed cancelled renting]

# Sample Users
puts "--- Generate User"
user = User.new(
  first_name: Faker::Name.unique.first_name,
  last_name: Faker::Name.unique.last_name,
  email: "zach@cars.com",
  address: "Melbourne, AUS",
)
user.password = "abc123"
user.save!

second_user = User.new(
  first_name: Faker::Name.unique.first_name,
  last_name: Faker::Name.unique.last_name,
  email: "erik@cars.com",
  address: "Melbourne, AUS",
)
second_user.password = "abc123"
second_user.save!

third_user = User.new(
  first_name: Faker::Name.unique.first_name,
  last_name: Faker::Name.unique.last_name,
  email: "harshil@cars.com",
  address: "Melbourne, AUS",
)
third_user.password = "abc123"
third_user.save!
puts "Finished generated User ---"


# Sample Cars
puts "--- Generate Car"
users = User.all
10.times do
  car = Car.new(
    name: "#{Faker::Vehicle.manufacture} #{Faker::Vehicle.make_and_model}",
    year: rand(1900..1980),
    seats: rand(2..6),
    price: rand(50..100) + rand.floor(2),
    location: "#{suburbs.sample}, VIC, AU"
  )
  # 1 Car always belong to 1 User, 1 User may not own a Car
  car.user = users.sample
  car.save!
end
puts "Finished generated User ---"

# Sample Booking
puts "--- Generate Booking"
5.times do 
  booking = Booking.new(
    start_date: DateTime.now,
    end_date: DateTime.now + rand(1..7)
  )
  booking.user = user
  booking.car = Car.find(rand(Car.first.id..Car.last.id))
  booking.booking_price = (booking.end_date - booking.start_date) * booking.car.price
  booking.status = booking_status.sample
  booking.save!
end
puts "Finished generated Booking ---"

# Sample Reviews -- placeholder
