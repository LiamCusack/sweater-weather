Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/forecast', to: 'forecast#index'
      get '/munchies', to: 'munchies#index'
      get '/trails', to: 'trails#index'
      get '/backgrounds', to: 'backgrounds#index'
      post '/users', to: 'users#create'
      post '/sessions', to: 'sessions#login'
      post '/road_trip', to: 'road_trip#create'
    end
  end
end
