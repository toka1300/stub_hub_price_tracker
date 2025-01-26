Rails.application.routes.draw do
  get "sessions/new"
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
  root "static_pages#home"
end
