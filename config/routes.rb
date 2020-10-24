Rails.application.routes.draw do
  devise_for :users
  root to: 'links#index'
  resources :links do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end
   get '/comments' => 'comments#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
