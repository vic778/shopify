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
  
  post "items/add_to_cart/:id", to: "items#add_to_cart", as: "add_to_cart"
  delete "items/remove_from_cart/:id", to: "items#remove_from_cart", as: "remove_from_cart"
end
