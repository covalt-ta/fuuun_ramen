Rails.application.routes.draw do
  get 'cards/new'
  devise_for :admins
  devise_for :users
  root 'products#index'
  resources :products, only: %i(show)
  resources :card, only: [:new, :create]
  namespace :admins do
    root to: "dashboard#index"
    resources :products, only: %i(new create)
  end
end
