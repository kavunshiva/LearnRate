Rails.application.routes.draw do


  resources :ratings
  resources :lessons
  resources :reviews
  resources :users
  resources :sessions

  root "new_age#index"
  get 'new_age/index', to:"new_age#index"

  resources :welcome, only: :index

  get '/help', to: "tags#index", as: "help"

  get '/login', to: "new_age#login", as: "login"
  get '/signup', to: "new_age#signup", as: "signup"
  # post '/sessions', to: "sessions#create", as: "sessions"
  delete '/logout', to: "sessions#destroy", as: "logout"
  get '/signup', to: "users#new"
  get '/search', to: "lessons#search", as: "search"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
