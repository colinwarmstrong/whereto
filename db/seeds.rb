require 'csv'

CSV.foreach('./db/data/city_data.csv', headers: true, header_converters: :symbol) do |city|
  City.find_or_create()
end
