Rails.application.routes.draw do
  get 'users/show'
  get 'cards/new'
  devise_for :admins
  devise_for :users
  root 'products#index'
  resources :products, only: %i(show)
  resources :users, only: %i(show update)
  resources :cards, only: %i(new create)

  namespace :admins do
    root to: "dashboard#index"
    resources :products, only: %i(new create)
  end
end
