Rails.application.routes.draw do
  post '/signup', to: 'users#create'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  namespace :api do
    namespace :v1 do
      resources :cities, only: [:index, :show]
    end
  end
end
