require 'rails_helper'

describe 'City API Endpoints' do
  context 'GET /api/v1/cities' do
    it 'returns data about all cities in the database' do
      city_1 = City.create(name: 'Denver', state: 'Colorad', rank: 22, growth: '5.7', population: 1345127, latitude: '49.8781136', longitude: '-82.6297982')
      city_2 = City.create(name: 'Chicago', state: 'Illinois', rank: 3, growth: '3.4', population: 3445993, latitude: '41.8781136', longitude: '-87.6297982')

      get '/api/v1/cities'

      expect(response.status).to eq(200)

      cities = JSON.parse(response.body, symbolize_names: true)

      denver  = cities[0]
      chicago = cities[1]
      
      expect(cities).to be_an(Array)
      expect(cities.length).to eq(2)

      expect(denver).to be_a(Hash)
      expect(denver[:name]).to eq(city_1.name)
      expect(denver[:state]).to eq(city_1.state)
      expect(denver[:rank]).to eq(city_1.rank)
      expect(denver[:growth]).to eq(city_1.growth)
      expect(denver[:population]).to eq(city_1.population)
      expect(denver[:latitude]).to eq(city_1.latitude)
      expect(denver[:longitude]).to eq(city_1.longitude)

      expect(chicago).to be_a(Hash)
      expect(chicago[:name]).to eq(city_2.name)
      expect(chicago[:state]).to eq(city_2.state)
      expect(chicago[:rank]).to eq(city_2.rank)
      expect(chicago[:growth]).to eq(city_2.growth)
      expect(chicago[:population]).to eq(city_2.population)
      expect(chicago[:latitude]).to eq(city_2.latitude)
      expect(chicago[:longitude]).to eq(city_2.longitude)
    end
  end
end
