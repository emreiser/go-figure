Project1::Application.routes.draw do
  devise_for :users
  resources :users
  resources :categories
  resources :countries
  resources :bias_points

  resources :questions
  resources :answers

	get '/about' => 'questions#about'
  root to: 'questions#landing'
end