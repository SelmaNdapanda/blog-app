Rails.application.routes.draw do
  # get 'users', to: 'users#index'
  # get 'users/:id', to: 'users#show'
  # get 'users/:id/posts', to: 'posts#index'
  # get 'users/:id/posts/:id', to: 'posts#show'
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show]
  end
  root to: "users#index"
end
