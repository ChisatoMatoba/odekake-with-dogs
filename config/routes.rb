Rails.application.routes.draw do
  devise_for :users
  get 'posts/index'
  get '/mobirise2.woff', to: redirect('/assets/mobirise-icons2/mobirise2.woff')
  get '/mobirise2.ttf', to: redirect('/assets/mobirise-icons2/mobirise2.woff')
  root to: "posts#index"
  resources :posts do
    resources :comments, only: :create
  end
  resources :users, only: :show do
    resources :dogs, only: [:new, :create]
  end
end
