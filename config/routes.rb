Rails.application.routes.draw do
  post "main/endpoint_one"
  get "main/endpoint_two"
  match "/404", via: :all, to: "errors#not_found"
  match "/500", via: :all, to: "errors#internal_server_error"
  get 'institution_votes', to: 'institution_votes#index'

  resources :votations, only: [:index, :create, :new]

  resources :votes do 
    get 'mesa', to: 'votes#by_table', on: :collection
    get 'institucion', to: 'votes#by_institution', on: :collection
    get 'grafic_data', on: :collection
    get 'show_by_table', on: :member
  end
  resources :tables_political_parties
  resources :politicians_parties
  resources :politician_rols
  resources :political_parties
  resources :headquarter_affiliateds
  resources :affiliated_rols
  resources :headquarters
  resources :dni_types
  resources :tables do 
    get 'by_institution', on: :collection
    get 'modal_clean_votes', on: :member
    post 'clean_votes', on: :member
  end
  resources :institutions do 
    get 'list_fiscal', on: :collection
  end
  resources :institution_types

  resources :neighborhoods do 
    get 'fix_neighborhood', on: :collection
  end
  
  resources :cities
  resources :provinces
  resources :people do 
    get 'import', on: :collection
    get 'import_neighborhood', on: :collection
  end
  post 'disable_person', to: 'people#disable', as: 'disable_person'
  post 'disable_table', to: 'tables#disable', as: 'disable_table'

  namespace :authentication, path: '', as: '' do
    resources :users, only: [:index,:new, :create, :edit, :update]
      post 'disable_user', to: 'users#disable', as: 'disable_user'
    resources :sessions, only: [:create]
    get 'login', to: 'sessions#new', as: 'login'
    get 'logout', to: 'sessions#destroy', as: 'logout'
  end

  root "votes#index"
  get "reports/people_list", to: "reports#people_list"
end
