require 'rails_helper'

describe 'Authentication Endpoints' do
  context 'POST /signup' do
    it 'creates a new user when given valid credentials' do
      user_payload = {user: {
                        email: 'test@test.com',
                        first_name: 'Colin',
                        last_name: 'Armstrong',
                        password: 'password1234'
                      }}

      expect(User.count).to eq(0)

      post '/signup', params: user_payload

      expect(response.status).to eq(201)

      new_user = JSON.parse(response.body, symbolize_names: true)

      binding.pry
      
      expect(new_user[:id]).to eq(User.last.id)
      expect(new_user[:email]).to eq(User.last.email)
      expect(new_user[:first_name]).to eq(User.last.first_name)
      expect(new_user[:last_name]).to eq(User.last.last_name)
    end
  end
end
