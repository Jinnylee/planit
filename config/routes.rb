Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  root 'static_pages#index'

  resources :trips, only: [:index, :show, :create, :update, :destroy] do
    resources :flights, only: [:index, :create, :update, :destroy]
    resources :activities, only: [:index, :create, :update, :destroy]
    resources :expenses, only: [:index, :create, :update, :destroy]
    resources :accommodations, only: [:index, :create, :update, :destroy]
    resources :packing, only: [:index, :create, :update, :destroy]
  end
end
