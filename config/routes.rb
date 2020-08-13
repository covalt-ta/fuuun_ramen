Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  root 'products#index'
  resources :products, only: %i(new create)
end
