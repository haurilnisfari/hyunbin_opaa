Rails.application.routes.draw do
  root 'expenses#new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :expenses
end
