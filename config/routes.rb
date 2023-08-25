Rails.application.routes.draw do
  devise_for :users
  get 'posts/index'
  root to: "posts#index"
  resources :posts do
    resources :comments, only: :create
  end
  resources :users, only: :show do
    resources :dogs, only: [:new, :create]
  end
end
