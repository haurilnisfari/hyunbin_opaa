Rails.application.routes.draw do
  root 'expenses#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :expenses
  resources :categories
  resources :accounts, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]
  get 'signup', to: 'accounts#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as:'logout'
end
