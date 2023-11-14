Rails.application.routes.draw do
  root 'static_pages#top'
  
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  
  resources :users, only: %i[new create]
  resources :records, only: %i[index new create edit update]
  resources :drinks, only: %i[new create]
  resource :profile, only: %i[edit update]
end
