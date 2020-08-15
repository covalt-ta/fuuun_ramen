Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  root 'products#index'

  resources :products, only: %i(show) do
    scope module: :products do
      resources :add_to_baskets, only: :create
      resources :delete_in_baskets, only: :create
    end
  end

  resources :users, only: %i(show update)
  resources :cards, only: %i(new create)
  resource :basket, only: :show
  resource :charge, only: :create

  namespace :admins do
    root to: "dashboards#index"
    resources :products, only: %i(new create)
  end
end
