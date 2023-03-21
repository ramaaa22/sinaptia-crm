Rails.application.routes.draw do
  devise_for :users
  resources :tags
  resources :clients do
    resources :notes
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "clients#index"
end
