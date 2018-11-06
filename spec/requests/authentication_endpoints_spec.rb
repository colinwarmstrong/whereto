require 'rails_helper'

describe 'Authentication Endpoints' do
  context 'POST /signup' do
    it 'creates a new user when given valid credentials' do
      user_payload = {user: {
                        email: 'test@test.com',
                        first_name: 'Colin',
                        last_name: 'Armstrong',
                        password: 'password1234'
                       }
                      }

      expect(User.count).to eq(0)

      post '/signup', params: user_payload

      expect(response.status).to eq(201)

      new_user = JSON.parse(response.body, symbolize_names: true)

      expect(new_user[:id]).to eq(User.last.id)
      expect(new_user[:email]).to eq(User.last.email)
      expect(new_user[:first_name]).to eq(User.last.first_name)
      expect(new_user[:last_name]).to eq(User.last.last_name)
    end
  end

  context 'POST /login' do
    it 'creates a new user when given valid credentials' do
      user = User.create(email: 'test@test.com', first_name: 'Colin', last_name: 'Armstrong', password: 'password1234')

      login_payload = {user: {
                         email: user.email,
                         password: user.password
                        }
                       }

      post '/login', params: login_payload

      expect(response.status).to eq(200)

      returned_user = JSON.parse(response.body, symbolize_names: true)

      expect(returned_user[:id]).to eq(user.id)
      expect(returned_user[:email]).to eq(user.email)
      expect(returned_user[:first_name]).to eq(user.first_name)
      expect(returned_user[:last_name]).to eq(user.last_name)
    end
  end

  context 'POST /login' do
    it 'creates a new user when given valid credentials' do
      user = User.create(email: 'test@test.com', first_name: 'Colin', last_name: 'Armstrong', password: 'password1234')

      login_payload = {user: {
                         email: user.email,
                         password: user.password
                        }
                       }

      post '/login', params: login_payload

      expect(response.status).to eq(200)

      delete '/logout'

      expect(response.status).to eq(200)

      returned_message = JSON.parse(response.body, symbolize_names: true)

      expect(returned_message[:message]).to eq('Succesfully logged out')
    end
  end
end
