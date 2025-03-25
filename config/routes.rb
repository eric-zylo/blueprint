Rails.application.routes.draw do
  require 'sidekiq/web'

  mount Sidekiq::Web => '/sidekiq'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations'
  }

  authenticated :user do
    root to: "dashboard#index", as: :authenticated_root
  end
  
  unauthenticated do
    devise_scope :user do
      root to: "users/sessions#new", as: :unauthenticated_root
    end
  end

  scope '/u' do
    resources :users, only: [] do
      resources :patients, only: [:index, :new, :create, :edit, :update, :destroy]
    end
  end
end
