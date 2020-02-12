Rails.application.routes.draw do
  devise_for :users
  root 'home#top'
  get 'home/about'
  resources :users,only: [:show,:index,:edit,:update]
  resources :books,only: [:index, :show, :edit, :update, :destroy]do
  resource :favorites, only: [:create, :destroy]
  resources :book_comments, only: [:create, :destroy]
end
end



