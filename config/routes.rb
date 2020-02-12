Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
  devise_for :users
  root 'home#top'
  get 'home/about'
  resources :users,only: [:show,:index,:edit,:update]do
  resource :relationships, only: [:create, :destroy]
     get :follows, on: :member
     get :followers, on: :member
   end
  resources :books,only: [:index, :show, :edit, :update, :destroy]do
  resource :favorites, only: [:create, :destroy]
  resources :book_comments, only: [:create, :destroy]
end
end



