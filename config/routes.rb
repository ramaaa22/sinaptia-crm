Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  # resources :users_admin, controller: "users"
  scope "/admin" do
    resources :users
  end
  
  resources :tags
  
  resources :companies do
    member do
      put :join
    end
  end

  resources :clients do
    resources :notes
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "clients#index"
end
