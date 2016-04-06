Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  root 'static_pages#index'

  post 'members/join_by_hash', to: 'members#join_by_hash'
  get 'trips/:trip_id/members/pending', to: 'members#pending'
  get  'trips/:trip_id/users', to: 'trips#get_users'
  get 'trips/:trip_id/sidebar', to: 'trips#get_specific_trip'

  get 'trips/:trip_id/chats', to: 'chats#index'
  post 'trips/:trip_id/chats', to: 'chats#create'

  resources :trips, only: [:index, :show, :create, :update, :destroy] do
    resources :members, only: [:index, :create, :update, :destroy]
    resources :flights, only: [:index, :show, :create, :update, :destroy]
    resources :activities, only: [:index, :show, :create, :update, :destroy]
    resources :expenses, only: [:index, :show, :create, :update, :destroy]
    resources :accommodations, only: [:index, :show, :create, :update, :destroy]
    resources :packings, only: [:index, :create, :update, :destroy]
  end
end
