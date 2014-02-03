Project1::Application.routes.draw do
  resources :categories
  resources :countries
  root to: 'categories#index'
end