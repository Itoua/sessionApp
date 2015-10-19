Rails.application.routes.draw do

  devise_for :users

  resources :articles do
     resources :comments, only: [ :create, :edit, :update, :destroy]

   end
  root to:'articles#index'
end
