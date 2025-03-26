Rails.application.routes.draw do
  require 'sidekiq/web'

  mount Sidekiq::Web => '/sidekiq'

  namespace :api do
    namespace :v1 do
      resources :diagnostic_screener_instances, only: [:show] do
        collection do
          post :score
        end
      end
    end
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations'
  }

  authenticated :user do
    root to: "patients#index", as: :authenticated_root
  end
  
  unauthenticated do
    devise_scope :user do
      root to: "users/sessions#new", as: :unauthenticated_root
    end
  end

  resources :users, only: [] do
    resources :patients do
      resources :diagnostic_screener_instances, only: [:create]
    end
  end

  get 'diagnostic_screener_instances/:token', to: 'diagnostic_screener_instances#show', as: 'diagnostic_screener'
end
