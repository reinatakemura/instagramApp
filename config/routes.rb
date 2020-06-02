Rails.application.routes.draw do
  devise_for :users, 
    controllers: { registrations: 'registrations' }
    
  root 'posts#index'

  get '/users/:id', to: 'users#show', as: 'user' # 後でresourcesに変更する

  resources :posts, only: [:index, :show, :new, :create, :destroy] do
    resources :photos, only: [:create]
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
end
