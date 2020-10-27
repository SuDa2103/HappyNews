Rails.application.routes.draw do
  devise_for :users
  root to: 'links#index'
  get '/newest' => 'links#newest'
  get '/myposts' => 'links#myposts'
  resources :links do
    resources :comments, only: [:create, :edit, :update, :destroy]
    post :upvote, on: :member
  end
   get '/comments' => 'comments#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
