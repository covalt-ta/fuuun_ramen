Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  root 'products#index'
  resources :products, only: %i(show)
  namespace :admins do
    root to: "dashboard#index"
    resources :products, only: %i(new create)
  end
end
