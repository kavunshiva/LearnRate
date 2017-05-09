Rails.application.routes.draw do
  resources :tags
  resources :ratings
  resources :lessons
  resources :reviews
  resources :users
  resources :sessions

  root "sessions#new"
  resources :welcome, only: :index

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
