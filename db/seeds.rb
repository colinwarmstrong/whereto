require 'csv'

puts 'Seeding...'

CSV.foreach('./db/data/city_data.csv', headers: true, header_converters: :symbol) do |city|
  City.create!(name:      city[:city],
              rank:       city[:rank],
              state:      city[:state],
              growth:     city[:growth].delete('.').to_i,
              population: city[:population],
              latitude:   city[:latitude],
              longitude:  city[:longitude])
end

user = User.create!(email: 'colinwarmstrong@gmail.com', password: 'password', first_name: 'Colin', last_name: 'Armstrong')

chicago = City.find_by_name('Chicago')
denver = City.find_by_name('Denver')
houston = City.find_by_name('Houston')
boston = City.find_by_name('Boston')
raleigh = City.find_by_name('Raleigh')

user.favorites.create!(city_id: chicago.id)
user.favorites.create!(city_id: denver.id)
user.favorites.create!(city_id: houston.id)
user.favorites.create!(city_id: boston.id)
user.favorites.create!(city_id: raleigh.id)

milwaukee = City.find_by_name('Milwaukee')
dallas = City.find_by_name('Dallas')
miami = City.find_by_name('Miami')
new_orleans = City.find_by_name('New Orleans')
los_angeles = City.find_by_name('Los Angeles')

user.rejections.create!(city_id: milwaukee.id)
user.rejections.create!(city_id: dallas.id)
user.rejections.create!(city_id: miami.id)
user.rejections.create!(city_id: new_orleans.id)
user.rejections.create!(city_id: los_angeles.id)

puts 'Seeding complete.'
puts "Seeded #{City.count} cities"
puts "Seeded #{User.count} users"
puts "Seeded #{Favorite.count} favorites"
puts "Seeded #{Rejection.count} rejections"
