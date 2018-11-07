require 'rails_helper'

describe 'Favorites Endpoints' do
  context 'GET /api/v1/rejections' do
    it 'returns all favorited cities for a user' do
      user = User.create(email: 'test@test.com', password: 'password1234', first_name: 'Colin', last_name: 'Armstrong')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      denver  = City.create(name: 'Denver', state: 'Colorado', rank: 22, growth: '5.7', population: 1345127, latitude: '49.8781136', longitude: '-82.6297982')
      chicago = City.create(name: 'Chicago', state: 'Illinois', rank: 3, growth: '3.4', population: 3445993, latitude: '41.8781136', longitude: '-87.6297982')

      user.rejections.create(city_id: denver.id)
      user.rejections.create(city_id: chicago.id)

      get '/api/v1/rejections'

      expect(response.status).to eq(200)

      rejected_cities = JSON.parse(response.body, symbolize_names: true)
      city_1 = rejected_cities[0]
      city_2 = rejected_cities[1]

      expect(rejected_cities).to be_an(Array)
      expect(rejected_cities.length).to eq(2)

      expect(city_1).to be_a(Hash)
      expect(city_1[:id]).to eq(chicago.id)
      expect(city_1[:name]).to eq(chicago.name)
      expect(city_1[:state]).to eq(chicago.state)
      expect(city_1[:rank]).to eq(chicago.rank)
      expect(city_1[:growth]).to eq((chicago.growth.to_f / 10.to_f).round(2))
      expect(city_1[:population]).to eq(chicago.population)
      expect(city_1[:latitude]).to eq(chicago.latitude)
      expect(city_1[:longitude]).to eq(chicago.longitude)

      expect(city_2).to be_a(Hash)
      expect(city_2[:id]).to eq(denver.id)
      expect(city_2[:name]).to eq(denver.name)
      expect(city_2[:state]).to eq(denver.state)
      expect(city_2[:rank]).to eq(denver.rank)
      expect(city_2[:growth]).to eq((denver.growth.to_f / 10.to_f).round(2))
      expect(city_2[:population]).to eq(denver.population)
      expect(city_2[:latitude]).to eq(denver.latitude)
      expect(city_2[:longitude]).to eq(denver.longitude)
    end
  end

  context 'POST /api/v1/rejections' do
    it "adds a city to a user's rejections" do
      user = User.create(email: 'test@test.com', password: 'password1234', first_name: 'Colin', last_name: 'Armstrong')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      denver = City.create(name: 'Denver', state: 'Colorado', rank: 22, growth: '5.7', population: 1345127, latitude: '49.8781136', longitude: '-82.6297982')

      favorite_payload = {city_id: denver.id}

      expect(user.rejections.count).to eq(0)

      post '/api/v1/rejections', params: favorite_payload

      expect(user.rejections.count).to eq(1)

      expect(response.status).to eq(200)

      new_rejection = JSON.parse(response.body, symbolize_names: true)

      expect(new_rejection).to be_a(Hash)
      expect(new_rejection[:id]).to eq(denver.id)
      expect(new_rejection[:name]).to eq(denver.name)
      expect(new_rejection[:state]).to eq(denver.state)
      expect(new_rejection[:rank]).to eq(denver.rank)
      expect(new_rejection[:growth]).to eq((denver.growth.to_f / 10.to_f).round(2))
      expect(new_rejection[:population]).to eq(denver.population)
      expect(new_rejection[:latitude]).to eq(denver.latitude)
      expect(new_rejection[:longitude]).to eq(denver.longitude)
    end

    it 'returns a 404 if given an invalid city id' do
      user = User.create(email: 'test@test.com', password: 'password1234', first_name: 'Colin', last_name: 'Armstrong')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      favorite_payload = {city_id: 1}

      expect(user.rejections.count).to eq(0)

      post '/api/v1/rejections', params: favorite_payload

      expect(user.rejections.count).to eq(0)

      expect(response.status).to eq(404)

      error_message = JSON.parse(response.body, symbolize_names: true)

      expect(error_message[:message]).to eq('Invalid request.')
    end

    it 'returns a 404 if no current user' do
      favorite_payload = {city_id: 1}

      post '/api/v1/rejections', params: favorite_payload

      expect(response.status).to eq(404)

      error_message = JSON.parse(response.body, symbolize_names: true)

      expect(error_message[:message]).to eq('Invalid request.')
    end
  end
end
