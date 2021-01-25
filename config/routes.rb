Rails.application.routes.draw do
  root 'expenses#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :expenses do
    collection do
      post :import
    end
  end

  resources :categories
  resources :budgets
  resources :accounts
  resources :users, only: [:new, :create, :destroy]
  resources :sessions, only: [:new, :create, :destroy]
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as:'logout'
end
