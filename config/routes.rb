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

  resources :users, only: %i(show)
  resources :cards, only: %i(new create destroy)
  resources :addresses, only: %i(new create update destroy)
  resource :basket, only: :show
  resources :charges, only: %i(new create) do
    collection do
      get 'new_reservation'
      post 'create_reservation'
    end
  end

  namespace :admins do
    root to: "dashboards#index"
    resources :products, only: %i(new create edit update destroy)
  end
end
