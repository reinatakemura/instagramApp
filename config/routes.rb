Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'

  get 'users/:id', to: 'users#show', as: 'user' # 後でresourcesに変更する

end
