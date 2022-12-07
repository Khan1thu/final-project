Rails.application.routes.draw do
  resources :likes, only: [:create, :destroy]
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks'}
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "posts#index"
  resources :posts do
    resources :comments, only: [:create]
  end
  resources :users, only: [:show] 
  post 'users/:id/follow', to: 'user#follow', as: 'follow'
  post 'users/:id/unfollow', to: 'user#unfollow', as: 'unfollow'
  post 'users/:id/accept', to: 'user#accept', as: 'accept'
  post 'users/:id/decline', to: 'user#decline', as: 'decline'
  post 'users/:id/cancel', to: 'user#cancel', as: 'cancel'

end
