Rails.application.routes.draw do
  resources :events, :price_alerts

  get "/contact", to: "static_pages#contact"
  get "/help", to: "static_pages#help"
  get "/signup", to: "users#new"

  root "price_alerts#index"
end
