Project1::Application.routes.draw do
  devise_for :users
  resources :categories
  resources :countries
  root to: 'games#index'
end