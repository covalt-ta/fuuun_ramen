Rails.application.routes.draw do
  devise_for :admins, controllers: {sessions: 'admins/sessions'}

  devise_scope :admin do
    get "sign_in", to: "admins/sessions#new"
  end

  devise_for :users

  root 'home#index'
  get 'home/test_sign_in', to: 'home#test_sign_in'

  resources :products, only: %i(index show) do
    resources :comments, only: %i(create destroy)
    resources :product_eats, only: %i(create destroy)
    scope module: :product_toppings do
      resources :add_to_baskets, only: :create
    end
  end

  resources :product_toppings, only: :show do
    scope module: :product_toppings do
      resources :delete_in_baskets, only: :create
    end
  end

  resources :users, only: %i(show update)
  resources :cards, only: %i(new create destroy)
  resources :addresses, only: %i(new create update destroy)
  resources :rooms, only: %i(index show)
  resource :message, only: :create
  resource :basket, only: :show
  resource :contact, only: :create
  resources :charges, only: %i(new create) do
    collection do
      get 'new_reservation'
      post 'create_reservation'
    end
  end

  namespace :admins do
    root to: "dashboards#index"
    get 'dashboards/search', to: 'dashboards#search'
    get 'dashboards/ranking', to: 'dashboards#ranking'
    resources :products, only: %i(index new create edit update destroy)
    resources :toppings, only: %i(create edit update destroy)
    resources :informations, only: %i(create edit update destroy)
    resources :reservations, only: %i(index show)
    resources :notices, only: :index
    resources :shops, only: %i(new show create update)
    resources :holidays, only: %i(create destroy)
    resources :rooms, only: %i(index show)
    resource :message, only: :create
  end
end
