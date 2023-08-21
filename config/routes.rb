Rails.application.routes.draw do
  devise_for :users
  root "home#index"

  resources :home, only: [:show, :destroy]

  resources :projects do
       resources :bugs,only: [:new, :create]
  end

  resources :bugs, except: [:new,:create]
end
