Rails.application.routes.draw do
  devise_for :users
  resources :clients
  resources :notes
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "clients#index"
end
