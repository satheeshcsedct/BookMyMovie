Rails.application.routes.draw do
  root 'movies#index'
  resources :movies, only: [:index, :show]
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
end
