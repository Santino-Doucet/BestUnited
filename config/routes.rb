Rails.application.routes.draw do
  devise_for :users
  root to: "pages#index"
  resources :items, only: [:index, :show] do
    resources :order_items, only: [:create]
  end

  resources :carts, only: [:index, :show]

  patch 'carts', to: 'carts#send_order_to_merchant'

  get 'dashboard', to: 'users#show', as: 'dashboard'

  post 'items/:id', to: 'my_stocks#duplicate_item', as: 'duplicate_item'

  get 'my_stock', to: 'my_stocks#show', as: 'my_stock'

  get 'my_stock/items/new', to: 'my_stocks#add_item', as: 'add_item_to_stock'
  post 'my_stock/items', to: 'my_stocks#create_item'


  get 'my_stock/items/:id', to: 'my_stocks#show_item', as: 'show_item_in_stock'

  get 'my_stock/items/:id/edit', to: 'my_stocks#edit_item', as: 'edit_item_in_stock'
  patch 'my_stock/items/:id', to:'my_stocks#update_item'

  delete 'items/:id', to: 'my_stocks#destroy_item'

  resources :orders, only: [:index, :show, :update]

  resources :order_items, only: [:destroy]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
