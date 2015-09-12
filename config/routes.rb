Rails.application.routes.draw do
  devise_for :admins, controllers: { sessions: 'admins/sessions',
    passwords: 'admins/passwords', registrations: 'admins/registrations',
    confirmations: 'admins/confirmations' }

  resources :admins, only: [:show, :index]

  devise_for :users, controllers: { sessions: 'users/sessions',
    passwords: 'users/passwords', registrations: 'users/registrations',
    confirmations: 'users/confirmations' }

  resources :users, only: [:show, :index, :new]

  resources :users do
    collection { post :search, to: 'users#index' }
  end

  root 'static_pages#home'
  get 'about'   => 'static_pages#about'
  get 'contact' => 'static_pages#contact'
end
