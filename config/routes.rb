Rails.application.routes.draw do
  resources :events
  resources :price_alerts

  get "/users", to: "users#index"
  get "/users/:id", to: "users#show"

  root "price_alerts#index"
end
