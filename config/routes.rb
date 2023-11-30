Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  root 'static_pages#top'
  
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  
  resources :users, only: %i[new create show]
  resources :records, only: %i[index new create edit update]
  resources :drinks, only: %i[new create]
  resources :ranks, only: %i[index]
  resource :profile, only: %i[edit update]
  resources :password_resets, only: %i[new create edit update]
end
