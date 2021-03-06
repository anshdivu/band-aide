Rails.application.routes.draw do
  use_doorkeeper
  mount Upmin::Engine => '/admin'
  root to: 'bands/bands#index'
  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}

  resources :bands, module: :bands do
    resources :songs
    resources :users, only: :show
  end

  resources :users, module: :users, only: :show do
    resources :invitations, only: :index
    resources :bands, only: :index
  end

  resources :invitations, only: [:show, :create, :destroy]
  resources :memberships, only: [:create, :edit, :update, :destroy]
  resources :tracks, only: [:create, :destroy]
end
