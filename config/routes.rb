Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
  resources :home, only: [:show, :destroy]

  resources :projects do
       resources :bugs,only: [:new, :create]
  end

  resources :bugs, except: [:new,:create]



end
