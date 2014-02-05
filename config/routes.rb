Project1::Application.routes.draw do
  devise_for :users
  resources :categories
  resources :countries
  resources :criteria

  resources :questions
  resources :answers

	get '/about' => 'questions#about'
  root to: 'questions#landing'
end