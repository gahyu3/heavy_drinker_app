Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  root 'static_pages#top'
  get 'privacy', to: 'static_pages#privacy'
  get 'rule', to: 'static_pages#rule'
  
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  delete 'records/:day_date', to: 'records#record_destroy', as: :record_destroy
  delete 'drinks/:id', to: 'records#drink_destroy', as: :drink_destroy
  
  resources :users, only: %i[new create show]
  resources :records, only: %i[index new create]
  resources :drinks, only: %i[new create]
  resources :ranks, only: %i[index]
  resources :password_resets, only: %i[new create edit update]
  resources :notifications, only: %i[index]
  resource :profile, only: %i[edit update]
  resource :notification_setting, only: %i[edit update]
end
