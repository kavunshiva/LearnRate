Rails.application.routes.draw do

  resources :tags
  resources :ratings
  resources :lessons
  resources :reviews
  resources :users
  resources :sessions

  root "new_age#index"
  get 'new_age/index', to:"new_age#index"

  resources :welcome, only: :index

  get '/login', to: "new_age#login", as: "login"
  get '/signup', to: "new_age#signup", as: "signup"
  # post '/sessions', to: "sessions#create", as: "sessions"
  delete '/logout', to: "sessions#destroy", as: "logout"
  get '/signup', to: "users#new"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
