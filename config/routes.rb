Rails.application.routes.draw do
  root 'static_pages#home'
  get  '/help', to: 'static_pages#help'

  get  '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  resources :users do
    member do
      get :following, :followers
    end
  end

  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :posts
  resources :relationships, only: [:create, :destroy]
end
