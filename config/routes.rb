Rails.application.routes.draw do
  root "static_pages#home"
  get "/contact",    to: "static_pages#contact"
  get "/help",       to: "static_pages#help"
  get "/signup",     to: "users#new"
  get "/login",      to: "sessions#new"
  post "/login",     to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"

  resources :events, :users
  resources :account_activations, only: [ :edit ]
  resources :password_resets, only: [ :new, :create, :edit, :update ]
  resources :price_alerts, only: [ :create, :destroy ]
  get "price_alerts", to: "static_pages#home"
end
