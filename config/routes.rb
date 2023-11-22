Rails.application.routes.draw do
  devise_for :users
  get 'posts/index'
  root to: "posts#index"
  resources :facilities do
    resources :posts do
      resources :comments, only: :create
    end
  end
  resources :users, only: :show do
    resources :dogs, only: [:new, :create]
  end
end
