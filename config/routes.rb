Rails.application.routes.draw do
  devise_for :users

  root "dashboard#index"
  get "dashboard/exportar_csv", to: "dashboard#exportar_csv", as: :dashboard_csv

  resources :clientes
  resources :veiculos
  resources :ordem_servicos

  get "up" => "rails/health#show", as: :rails_health_check
end
