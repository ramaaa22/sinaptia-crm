Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  scope "/admin" do
    resources :users do
      member do
        post :restore
      end
    end
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
