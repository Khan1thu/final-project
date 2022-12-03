Rails.application.routes.draw do
  resources :likes, only: [:create, :destroy]
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "posts#index"
  resources :posts do
    resources :comments, only: [:create]
  end
  resources :users, only: :show do
    get 'posts'
    get 'photos'
    get 'friends'
    get 'likes'
  end
end
