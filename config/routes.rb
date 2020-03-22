Rails.application.routes.draw do
  root 'movies#index'
  resources :bookings, only: %i[index new create destroy] do
    collection do
      get 'validate_coupon_code'
    end
  end
  resources :movies, only: %i[index show] do
    collection do
      get 'theater_details'
    end
  end
  resources :users, only: %i[new create]
  resources :sessions, only: %i[new create destroy]
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
end
