Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    post 'users/sign_in' => 'users#login'
    get 'posts' => 'posts#index'
    get 'comments' => 'comments#index'
    post 'comments/create' => 'comments#create'
  end
  
  devise_scope :user do 
    get '/users/sign_out' => 'devise/sessions#destroy' 
  end

  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show new create destroy] do
      resources :comments, only: %i[create destroy]
      resources :likes, only: %i[create]
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'users#index'
end
