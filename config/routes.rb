Rails.application.routes.draw do
  devise_for :users
  resources :groups, only: [:index, :new, :create] do
    resources :records, only: [:index, :new, :create]
  end
  root 'home#index'
end
