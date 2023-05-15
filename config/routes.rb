Rails.application.routes.draw do
  resources :dni_types
  resources :tables
  resources :institutions
  resources :institution_types
  resources :neighborhoods
  resources :cities
  resources :provinces
  resources :people do 
    get 'import', on: :collection
    get 'import_neighborhood', on: :collection
  end
  post 'disable_person', to: 'people#disable', as: 'disable_person'

  namespace :authentication, path: '', as: '' do
    resources :users, only: [:index,:new, :create, :edit, :update]
      post 'disable_user', to: 'users#disable', as: 'disable_user'
    resources :sessions, only: [:create]
    get 'login', to: 'sessions#new', as: 'login'
    get 'logout', to: 'sessions#destroy', as: 'logout'
  end

  root "people#index"
end
