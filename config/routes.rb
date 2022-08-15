Rails.application.routes.draw do
  devise_for :users
  root "items#index"
  resources :items
  # resources :checkouts, only: [:create]
  # post "checkout/create", to: "checkout#create"
  post "checkout/create", to: "checkout#create"
  get "success", to: "checkout#success"
  get "cancel", to: "checkout#cancel"
  resources :webhooks, only: [:create]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
