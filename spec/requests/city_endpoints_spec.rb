require 'rails_helper'

describe 'City API Endpoints' do
  context 'GET /api/v1/cities' do
    it 'returns data about all cities in the database' do
      denver  = City.create(name: 'Denver', state: 'Colorado', rank: 22, growth: '5.7', population: 1345127, latitude: '49.8781136', longitude: '-82.6297982')
      chicago = City.create(name: 'Chicago', state: 'Illinois', rank: 3, growth: '3.4', population: 3445993, latitude: '41.8781136', longitude: '-87.6297982')

      get '/api/v1/cities'

      expect(response.status).to eq(200)

      cities = JSON.parse(response.body, symbolize_names: true)

      city_1 = cities[0]
      city_2 = cities[1]

      expect(cities).to be_an(Array)
      expect(cities.length).to eq(2)

      expect(city_1).to be_a(Hash)
      expect(city_1[:id]).to eq(chicago.id)
      expect(city_1[:name]).to eq(chicago.name)
      expect(city_1[:state]).to eq(chicago.state)
      expect(city_1[:rank]).to eq(chicago.rank)
      expect(city_1[:growth]).to eq(chicago.growth)
      expect(city_1[:population]).to eq(chicago.population)
      expect(city_1[:latitude]).to eq(chicago.latitude)
      expect(city_1[:longitude]).to eq(chicago.longitude)

      expect(city_2).to be_a(Hash)
      expect(city_2[:id]).to eq(denver.id)
      expect(city_2[:name]).to eq(denver.name)
      expect(city_2[:state]).to eq(denver.state)
      expect(city_2[:rank]).to eq(denver.rank)
      expect(city_2[:growth]).to eq(denver.growth)
      expect(city_2[:population]).to eq(denver.population)
      expect(city_2[:latitude]).to eq(denver.latitude)
      expect(city_2[:longitude]).to eq(denver.longitude)
    end
  end

  context 'GET /api/v1/cities/:id' do
    it 'returns data about a specific city in the database' do
      denver = City.create(name: 'Denver', state: 'Colorado', rank: 22, growth: '5.7', population: 1345127, latitude: '49.8781136', longitude: '-82.6297982')

      get "/api/v1/cities/#{denver.id}"

      expect(response.status).to eq(200)

      city = JSON.parse(response.body, symbolize_names: true)

      expect(city).to be_a(Hash)
      expect(city[:name]).to eq(denver.name)
      expect(city[:state]).to eq(denver.state)
      expect(city[:rank]).to eq(denver.rank)
      expect(city[:growth]).to eq(denver.growth)
      expect(city[:population]).to eq(denver.population)
      expect(city[:latitude]).to eq(denver.latitude)
      expect(city[:longitude]).to eq(denver.longitude)
    end

    it 'returns a 404 and an error message if no city is found' do
      invalid_id = 1

      get "/api/v1/cities/#{invalid_id}"

      expect(response.status).to eq(404)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error[:message]).to eq("Could not find a city with id #{invalid_id}")
    end
  end

  context 'GET /api/v1/cities?state=:state_name' do
    it 'returns data about all cities for a specific state' do
      denver  = City.create(name: 'Denver', state: 'Colorado', rank: 12, growth: '5.7', population: 2345127, latitude: '49.8781136', longitude: '-82.6297982')
      boulder = City.create(name: 'Boulder', state: 'Colorado', rank: 22, growth: '6.7', population: 1223456, latitude: '50.8781136', longitude: '-81.6297982')
      chicago = City.create(name: 'Chicago', state: 'Illinois', rank: 3, growth: '7.7', population: 339845, latitude: '51.8781136', longitude: '-83.6297982')

      get "/api/v1/cities?state=Colorado"

      expect(response.status).to eq(200)

      cities = JSON.parse(response.body, symbolize_names: true)
      city_1 = cities[0]
      city_2 = cities[1]

      expect(cities).to be_an(Array)
      expect(cities.length).to eq(2)

      expect(city_1).to be_a(Hash)
      expect(city_1[:id]).to eq(denver.id)
      expect(city_1[:name]).to eq(denver.name)
      expect(city_1[:state]).to eq(denver.state)
      expect(city_1[:rank]).to eq(denver.rank)
      expect(city_1[:growth]).to eq(denver.growth)
      expect(city_1[:population]).to eq(denver.population)
      expect(city_1[:latitude]).to eq(denver.latitude)
      expect(city_1[:longitude]).to eq(denver.longitude)

      expect(city_2).to be_a(Hash)
      expect(city_2[:id]).to eq(boulder.id)
      expect(city_2[:name]).to eq(boulder.name)
      expect(city_2[:state]).to eq(boulder.state)
      expect(city_2[:rank]).to eq(boulder.rank)
      expect(city_2[:growth]).to eq(boulder.growth)
      expect(city_2[:population]).to eq(boulder.population)
      expect(city_2[:latitude]).to eq(boulder.latitude)
      expect(city_2[:longitude]).to eq(boulder.longitude)
    end
  end

  context 'GET /api/v1/cities?sort=population' do
    it 'returns data about all cities sorted by population' do
      denver  = City.create(name: 'Denver', state: 'Colorado', rank: 12, growth: '5.7', population: 2345127, latitude: '49.8781136', longitude: '-82.6297982')
      boulder = City.create(name: 'Boulder', state: 'Colorado', rank: 22, growth: '6.7', population: 1223456, latitude: '50.8781136', longitude: '-81.6297982')
      chicago = City.create(name: 'Chicago', state: 'Illinois', rank: 3, growth: '7.7', population: 3239845, latitude: '51.8781136', longitude: '-83.6297982')

      get "/api/v1/cities?sort=population"

      expect(response.status).to eq(200)

      cities = JSON.parse(response.body, symbolize_names: true)
      city_1 = cities[0]
      city_2 = cities[1]
      city_3 = cities[2]

      expect(cities).to be_an(Array)
      expect(cities.length).to eq(3)

      expect(city_1).to be_a(Hash)
      expect(city_1[:id]).to eq(chicago.id)
      expect(city_1[:name]).to eq(chicago.name)
      expect(city_1[:state]).to eq(chicago.state)
      expect(city_1[:rank]).to eq(chicago.rank)
      expect(city_1[:growth]).to eq(chicago.growth)
      expect(city_1[:population]).to eq(chicago.population)
      expect(city_1[:latitude]).to eq(chicago.latitude)
      expect(city_1[:longitude]).to eq(chicago.longitude)

      expect(city_2).to be_a(Hash)
      expect(city_2[:id]).to eq(denver.id)
      expect(city_2[:name]).to eq(denver.name)
      expect(city_2[:state]).to eq(denver.state)
      expect(city_2[:rank]).to eq(denver.rank)
      expect(city_2[:growth]).to eq(denver.growth)
      expect(city_2[:population]).to eq(denver.population)
      expect(city_2[:latitude]).to eq(denver.latitude)
      expect(city_2[:longitude]).to eq(denver.longitude)

      expect(city_3).to be_a(Hash)
      expect(city_3[:id]).to eq(boulder.id)
      expect(city_3[:name]).to eq(boulder.name)
      expect(city_3[:state]).to eq(boulder.state)
      expect(city_3[:rank]).to eq(boulder.rank)
      expect(city_3[:growth]).to eq(boulder.growth)
      expect(city_3[:population]).to eq(boulder.population)
      expect(city_3[:latitude]).to eq(boulder.latitude)
      expect(city_3[:longitude]).to eq(boulder.longitude)
    end
  end

  context 'GET /api/v1/cities?sort=alphabetical' do
    it 'returns data about all cities sorted by population' do
      denver  = City.create(name: 'Denver', state: 'Colorado', rank: 12, growth: '5.7', population: 2345127, latitude: '49.8781136', longitude: '-82.6297982')
      boulder = City.create(name: 'Boulder', state: 'Colorado', rank: 22, growth: '6.7', population: 1223456, latitude: '50.8781136', longitude: '-81.6297982')
      chicago = City.create(name: 'Chicago', state: 'Illinois', rank: 3, growth: '7.7', population: 3239845, latitude: '51.8781136', longitude: '-83.6297982')

      get "/api/v1/cities?sort=alphabetical"

      expect(response.status).to eq(200)

      cities = JSON.parse(response.body, symbolize_names: true)
      city_1 = cities[0]
      city_2 = cities[1]
      city_3 = cities[2]

      expect(cities).to be_an(Array)
      expect(cities.length).to eq(3)

      expect(city_1).to be_a(Hash)
      expect(city_1[:id]).to eq(boulder.id)
      expect(city_1[:name]).to eq(boulder.name)
      expect(city_1[:state]).to eq(boulder.state)
      expect(city_1[:rank]).to eq(boulder.rank)
      expect(city_1[:growth]).to eq(boulder.growth)
      expect(city_1[:population]).to eq(boulder.population)
      expect(city_1[:latitude]).to eq(boulder.latitude)
      expect(city_1[:longitude]).to eq(boulder.longitude)

      expect(city_2).to be_a(Hash)
      expect(city_2[:id]).to eq(chicago.id)
      expect(city_2[:name]).to eq(chicago.name)
      expect(city_2[:state]).to eq(chicago.state)
      expect(city_2[:rank]).to eq(chicago.rank)
      expect(city_2[:growth]).to eq(chicago.growth)
      expect(city_2[:population]).to eq(chicago.population)
      expect(city_2[:latitude]).to eq(chicago.latitude)
      expect(city_2[:longitude]).to eq(chicago.longitude)

      expect(city_3).to be_a(Hash)
      expect(city_3[:id]).to eq(denver.id)
      expect(city_3[:name]).to eq(denver.name)
      expect(city_3[:state]).to eq(denver.state)
      expect(city_3[:rank]).to eq(denver.rank)
      expect(city_3[:growth]).to eq(denver.growth)
      expect(city_3[:population]).to eq(denver.population)
      expect(city_3[:latitude]).to eq(denver.latitude)
      expect(city_3[:longitude]).to eq(denver.longitude)
    end
  end
end
