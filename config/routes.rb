Rails.application.routes.draw do
  resources :tags
  resources :ratings
  resources :lessons
  resources :reviews
  resources :users

  root "welcome#index"
  resources :welcome, only: :index

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
