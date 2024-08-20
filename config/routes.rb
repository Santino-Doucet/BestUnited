Rails.application.routes.draw do
  devise_for :users
  root to: "pages#index"
  resources :items, only: [:index, :show]

  resources :carts, only: [:index, :show, :edit, :update] do
    resources :items, only: [:edit, :update]
  end

  get '/dashboard', to: 'users#show', as: 'dashboard'

  resources :my_stocks, only: [:index, :show, :new, :create] do
    resources :items, only: [:edit, :destroy]
  end


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
