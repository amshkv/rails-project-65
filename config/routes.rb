# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  scope module: :web do
    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    delete 'auth/logout'

    root 'welcome#index'

    resources :bulletins, only: %i[show new create]

    namespace :admin do
      root 'welcome#index'
      resources :bulletins, only: %i[index]
      resources :categories, only: %i[index new create edit update destroy]
    end
  end
end
