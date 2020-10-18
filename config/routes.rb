Rails.application.routes.draw do
  root 'static_pages#home'
  get  '/help', to: 'static_pages#help'

  get  '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  resources :users do
    member do
      get :following, :followers
    end
    resources :likes, only: [:index, :create, :destroy]
  end

  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get  '/posts/new', to: 'posts#new'
  post '/posts/new', to: 'posts#create'
  get  '/posts/search', to: 'posts#search'
  resources :posts

  resources :comments, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
end
