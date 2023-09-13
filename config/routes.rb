Rails.application.routes.draw do
  resources :products, only: [:index, :show] do
    resources :reviews, only: [:index], on: :member
  end

  # Defines the root path route ("/")
  root "products#index"
end
