Rails.application.routes.draw do
  devise_for :users
  root to: "pages#index"
  resources :items, only: [:index, :show]

  resources :carts, only: [:index, :show, :edit, :update] do
    resources :items, only: [:edit, :update]
  end

  patch 'carts', to: 'carts#send_order_to_merchant'

  get 'dashboard', to: 'users#show', as: 'dashboard'

  get 'my_stock', to: 'my_stocks#show', as: 'my_stock'

  get 'my_stock/items/new', to: 'my_stocks#add_item', as: 'add_item_to_stock'
  post 'my_stock/items', to: 'my_stocks#create_item'

  get 'my_stock/items/:id', to: 'my_stocks#show_item', as: 'show_item_in_stock'

  get 'my_stock/items/:id/edit', to: 'my_stocks#edit_item', as: 'edit_item_in_stock'
  patch 'my_stock/items/:id', to:'my_stocks#update_item'

  delete 'my_stock/items/:id', to: 'my_stocks#destroy_item'

  get 'orders', to: 'orders#index'
  get 'orders/:id', to: "orders#show"

  patch 'orders', to: 'orders#update'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
