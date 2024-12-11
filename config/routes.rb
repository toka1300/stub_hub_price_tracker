Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  get "/events", to: "events#index"
  get "/users", to: "users#index"
  get "/users/new", to: "users#new"
  root "events#index"
end
