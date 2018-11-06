require 'rails_helper'

describe 'Favorites Endpoints' do
  context 'GET /api/v1/favorites' do
    it 'returns all favorited cities for a user' do
      user = User.create(email: 'test@test.com', password: 'password1234', first_name: 'Colin', last_name: 'Armstrong')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      denver  = City.create(name: 'Denver', state: 'Colorado', rank: 22, growth: '5.7', population: 1345127, latitude: '49.8781136', longitude: '-82.6297982')
      chicago = City.create(name: 'Chicago', state: 'Illinois', rank: 3, growth: '3.4', population: 3445993, latitude: '41.8781136', longitude: '-87.6297982')

      user.favorites.create(city_id: denver.id)
      user.favorites.create(city_id: chicago.id)

      get '/api/v1/favorites'

      expect(response.status).to eq(200)

      favorite_cities = JSON.parse(response.body, symbolize_names: true)
      city_1 = favorite_cities[0]
      city_2 = favorite_cities[1]

      expect(favorite_cities).to be_an(Array)
      expect(favorite_cities.length).to eq(2)

      expect(city_1).to be_a(Hash)
      expect(city_1[:id]).to eq(denver.id)
      expect(city_1[:name]).to eq(denver.name)
      expect(city_1[:state]).to eq(denver.state)
      expect(city_1[:rank]).to eq(denver.rank)
      expect(city_1[:growth]).to eq((denver.growth.to_f / 10.to_f).round(2))
      expect(city_1[:population]).to eq(denver.population)
      expect(city_1[:latitude]).to eq(denver.latitude)
      expect(city_1[:longitude]).to eq(denver.longitude)

      expect(city_2).to be_a(Hash)
      expect(city_2[:id]).to eq(chicago.id)
      expect(city_2[:name]).to eq(chicago.name)
      expect(city_2[:state]).to eq(chicago.state)
      expect(city_2[:rank]).to eq(chicago.rank)
      expect(city_2[:growth]).to eq((chicago.growth.to_f / 10.to_f).round(2))
      expect(city_2[:population]).to eq(chicago.population)
      expect(city_2[:latitude]).to eq(chicago.latitude)
      expect(city_2[:longitude]).to eq(chicago.longitude)
    end
  end

  context 'POST /api/v1/favorites' do
    it "adds a city to a user's favorites" do
      user = User.create(email: 'test@test.com', password: 'password1234', first_name: 'Colin', last_name: 'Armstrong')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      denver = City.create(name: 'Denver', state: 'Colorado', rank: 22, growth: '5.7', population: 1345127, latitude: '49.8781136', longitude: '-82.6297982')

      favorite_payload = {city_id: denver.id}

      expect(user.favorites.count).to eq(0)

      post '/api/v1/favorites', params: favorite_payload

      expect(user.favorites.count).to eq(1)

      expect(response.status).to eq(200)

      new_favorite = JSON.parse(response.body, symbolize_names: true)

      expect(new_favorite).to be_a(Hash)
      expect(new_favorite[:id]).to eq(denver.id)
      expect(new_favorite[:name]).to eq(denver.name)
      expect(new_favorite[:state]).to eq(denver.state)
      expect(new_favorite[:rank]).to eq(denver.rank)
      expect(new_favorite[:growth]).to eq((denver.growth.to_f / 10.to_f).round(2))
      expect(new_favorite[:population]).to eq(denver.population)
      expect(new_favorite[:latitude]).to eq(denver.latitude)
      expect(new_favorite[:longitude]).to eq(denver.longitude)
    end

    it 'returns a 404 if given an invalid city id' do
      user = User.create(email: 'test@test.com', password: 'password1234', first_name: 'Colin', last_name: 'Armstrong')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      favorite_payload = {city_id: 1}

      expect(user.favorites.count).to eq(0)

      post '/api/v1/favorites', params: favorite_payload

      expect(user.favorites.count).to eq(0)

      expect(response.status).to eq(404)

      error_message = JSON.parse(response.body, symbolize_names: true)

      expect(error_message[:message]).to eq('Invalid request.')
    end

    it 'returns a 404 if no current user' do
      favorite_payload = {city_id: 1}

      post '/api/v1/favorites', params: favorite_payload

      expect(response.status).to eq(404)

      error_message = JSON.parse(response.body, symbolize_names: true)

      expect(error_message[:message]).to eq('Invalid request.')
    end
  end
end
