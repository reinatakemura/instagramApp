Rails.application.routes.draw do
  devise_for :users, 
    controllers: { registrations: 'registrations' }
    
  root 'pages#home'

  get '/users/:id', to: 'users#show', as: 'user' # 後でresourcesに変更する

  resources :posts, only: [:index, :new, :create] do
    resources :photos, only: [:create]
  end
end
