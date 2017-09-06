Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    get 'admin', to: 'devise/sessions#new'
  end

  root 'welcome#index'

  namespace :admin do
    resources :entries do
      get 'clone', on: :member

      get :diff, to: 'versions#diff'
      patch :rollback, to: 'versions#rollback'

      resources :items
      resource :download, only: [:show]
    end
    resources :settings
    resources :customers
    resources :versions do
      collection do
        get 'remove_all'
      end
    end
  end

end
