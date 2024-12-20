Rails.application.routes.draw do
  get "/contact", to: "static_pages#contact"
  get "/help", to: "static_pages#help"
  get "/signup", to: "users#new"

  resources :events, :price_alerts, :users
  root "price_alerts#index"
end
