require 'csv'

puts 'Seeding...'

CSV.foreach('./db/data/city_data.csv', headers: true, header_converters: :symbol) do |city|
  City.create!(name:      city[:city],
              rank:       city[:rank],
              state:      city[:state],
              growth:     city[:growth],
              population: city[:population],
              latitude:   city[:latitude],
              longitude:  city[:longitude])
end

puts 'Seeding complete.'
puts "Seeded #{City.count} cities"
